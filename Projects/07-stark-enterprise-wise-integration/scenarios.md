# Four Failure Scenarios

Once the payment gateway was live, I deliberately broke it four
different ways and diagnosed each failure the way a support engineer
would, using only the signals available at each layer. The goal was to
prove three things. The HTTP response alone tells you something
failed. The response body tells you what kind of failure it was. And
the platform logs tell you exactly why.

Two of the four scenarios, B1 and B2, are the real showcase. Both
return a 401 from Wise and would look identical to a customer
describing "my token doesn't work," but they point to two completely
different fixes.

## Summary Table

| Layer | Scenario | Status | Body |
|---|---|---|---|
| Platform and RBAC (Azure) | A, missing IAM role | 500 | Empty, unhandled exception |
| Application, third party (Wise) | B1, stale or garbage token | 401 | `{"error":"invalid_token"}` |
| Application, third party (Wise) | B2, valid but under permissioned token | 401 | `{"code":"error.quote.mustBeAuthenticated"}` |
| Edge and gateway (Azure Functions) | C, wrong function key | 401 | Empty, zero content length |

## Scenario A, Missing IAM Role

**Break.** Removed the Key Vault Secrets User role from
`func-stark-payments-gw`'s Managed Identity through the Key Vault's
Access control (IAM) page.

**Trigger.** `curl -i -X GET .../api/get_profiles?code=...`

**Result while broken.**

```
HTTP/1.1 500 Internal Server Error
Content-Length: 0
```

An unhandled exception in the Function's own code, with no graceful
error message returned to the caller.

**Kibana confirmation.** Searching `SecretGet` in Discover and
expanding the matching entry showed `azure.platformlogs.result_signature:
"Forbidden"`, confirming an authorization denial at the Key Vault
layer rather than a bug in the application code.

| Correlation ID | Local time | isRbacAuthorized | result_signature | What it proves |
|---|---|---|---|---|
| `33829d0c-f7fa-4950-b303-233c053ebef9` | 18:50:44 | false | Forbidden | Azure denied access at the Key Vault RBAC layer |
| `8f099b35-1df7-4cfa-bf00-223b67438bc2` | 18:50:54 | false | Forbidden | Same result, confirms consistency across retries |
| `6fc0f756-bd83-4de0-bfd4-fdf06de4b02d` | 20:35:21 | true | OK | Role reassignment fix confirmed effective |

**Fix.** Re-added the Key Vault Secrets User role and waited about two
minutes for propagation.

**Result after fix.** `HTTP/1.1 200 OK`, full Wise profile JSON
returned.

**Talking point.** The HTTP status told me something failed. The
empty response body told me it was an unhandled exception rather than
a graceful error. The Kibana platform log told me the precise cause,
an authorization denial rather than a bug in my code. Three signals,
three different tools, one root cause.

Scenario A is actually an Azure and IAM layer issue, something a Wise
support engineer would never have visibility into on a real customer's
own infrastructure. B1 and B2 below are the scenarios that actually
match a Wise support engineer's real vantage point, errors that
originate from Wise's own API, exactly what a customer would paste
into a support ticket with zero visibility into their own backend.

## Scenario B1, Stale or Invalid Downstream Credential

**Break.** Created a new version of the `wise-sandbox-token` secret
containing a garbage value, simulating a rotated or stale credential
that was never updated downstream.

**Trigger.** `bash test.sh` and `bash test2.sh` against `get_profiles`.

**Result.**

```
HTTP/1.1 401 Unauthorized
{"error_description":"Invalid token","error":"invalid_token"}
```

**Kibana confirmation.**

| Correlation ID | Local time | isRbacAuthorized | result_signature | What it proves |
|---|---|---|---|---|
| `f320dcea-c9eb-4832-b26b-2fd7b5a3abce` | 21:46:44 | true | OK | Azure succeeded, proving the failure was entirely downstream at Wise |

This is the cleanest before and after signal in the whole build.
`isRbacAuthorized` stays true and `result_signature` stays OK
throughout B1, even though the end to end call still failed with a
401. Azure did its job correctly. Wise rejected the credential itself.

As the support engineer receiving this ticket, there is no Azure
visibility available here. The full diagnostic surface is this JSON
body and the 401 status. The correct next step is asking the customer
how the token was generated and stored, not assuming the cause.

> **Restore issue hit.** I first tried restoring the real token by
> disabling the garbage secret version, assuming Key Vault would
> automatically fall back to the previous version. Instead this left
> the secret with no enabled version at all, producing a hard
> connection failure with zero bytes received rather than a clean HTTP
> error. Disabling a version does not promote an older version to
> current. Key Vault serves the newest enabled version only, and if
> that one is disabled with nothing to replace it, there is nothing
> left to serve. The fix was creating a genuinely new secret version
> with the real token value, not re-enabling the old one.

## Scenario B2, Valid Token With Insufficient Permission

**Break.** Swapped `wise-sandbox-token` to a genuinely valid Read only
personal API token.

**Trigger.** `bash test3.sh` against `create_payment_quote`, the write
action endpoint, chosen deliberately since a Read only token would
legitimately succeed at reading but should be rejected for creating a
quote.

**Result.**

```
HTTP/1.1 401 Unauthorized
{"errors":[{"code":"error.quote.mustBeAuthenticated","message":"You need to be authenticated to do that."}]}
```

**Why this is meaningfully different from B1.** B1's `invalid_token`
means Wise could not identify the caller at all, the token itself was
unrecognized. B2's `error.quote.mustBeAuthenticated` means Wise does
recognize this as a legitimate, valid token, it simply does not carry
enough authentication strength for this specific write action. The
token works fine at the account level. This particular operation
requires a stronger authentication tier than a Read only token
provides.

**Talking point.** A customer pasting either error into a ticket would
describe both as "my token doesn't work" at a glance, but they point
to completely different fixes. B1 needs a corrected or regenerated
token value. B2 needs the customer to reissue a Full access token,
since their existing token is already working correctly, just under
permissioned for what they are trying to do. Telling these apart from
the error code alone, instead of assuming invalid token always means
the same thing, is a real diagnostic skill, not a guess.

> **Issue hit while setting this scenario up.** I initially missed a
> single digit while copying the intended Read only token value into
> Key Vault. Wise returned the exact same `invalid_token` error as
> B1's genuinely garbage token. A truncated or incomplete token is
> functionally indistinguishable from a garbage one from the API's own
> perspective, since both fail authentication entirely before
> authorization is ever evaluated. That means "the customer says
> they're using their real token" cannot be assumed to mean the token
> is correctly and completely provided. For a real support ticket, if
> a customer reports `invalid_token`, the first troubleshooting
> question should not be whether the token expired. It should be
> asking them to regenerate and carefully re-paste the full value,
> since a partial copy and paste is a common, easy to miss root cause
> that produces this exact same generic error.

**Restore confirmed.** Real Full access token restored, `bash
test3.sh` returned `200 OK` with a genuine quote.

## Scenario C, Wrong or Missing Function Key

**Break.** Called `create_payment_quote` with an intentionally wrong
`?code=` value.

**Trigger.** `bash test4.sh`

**Result.**

```
HTTP/1.1 401 Unauthorized
Content-Length: 0
```

**Why this is a genuinely distinct signature.** Unlike B1 and B2,
which both return a 401 with a JSON body containing a Wise specific
error code, this response has zero body content. That is the actual
finding. This request was rejected by Azure Functions' own platform
level auth check before it ever reached the Python code, before any
Key Vault call, and before any Wise API call.

**Kibana confirmation.** No new `SecretGet` entry exists for this
request. The absence of a log entry is itself the diagnostic signal,
proving the request never got far enough to attempt the Key Vault call
at all.

## What This Proves
Three genuinely different response signatures, each isolating a
different point of failure using the same instinct. Is a structured
response present or not, which layer actually rejected the request,
and what that rules in or rules out. The real interview value is being
able to say which layer failed, not just that something failed.

## Known Limitation
Kibana coverage in this build is Azure and Key Vault side only. It
shows exactly what Azure did, `SecretGet` succeeded or was denied, but
it has no visibility into what Wise itself returned. A customer
reporting a 401 like B1 or B2 above would show up in Kibana as a
completely successful `SecretGet` event, since Azure's own job was
done correctly, with the actual failure invisible unless the raw curl
response or the Function's Log Stream is already open. Closing that
gap means having the Function forward Wise's own status code and
response body into a separate Elastic index at the moment it receives
them, giving a support engineer one searchable place to see both what
Azure did and what the third party API actually said. That is the
natural next step, documented here rather than built, since the
working diagnostic evidence above was already complete and accurate
without it.
