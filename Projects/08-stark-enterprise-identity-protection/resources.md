# Resources and References

## Microsoft Learn documentation used
- [Risk-based access policies](https://learn.microsoft.com/entra/id-protection/concept-identity-protection-policies): how sign-in risk and user risk feed Conditional Access
- [Require multifactor authentication for elevated sign-in risk](https://learn.microsoft.com/entra/identity/conditional-access/policy-risk-based-sign-in): confirms AADSTS53004 is the specific, documented result of a risky, MFA-unregistered sign-in
- [Remediate risks and unblock users](https://learn.microsoft.com/entra/id-protection/howto-identity-protection-remediate-unblock): dismiss vs. remediate, and the documented RiskDetail values each action produces
- [riskDetail enum type (Microsoft Graph)](https://learn.microsoft.com/graph/api/resources/riskdetail): full list of RiskDetail values, used to confirm the label mismatch in [scenarios.md](./scenarios.md)
- [riskyUser resource type (Microsoft Graph)](https://learn.microsoft.com/graph/api/resources/riskyuser): schema for `Get-MgRiskyUser` output
- [Conditional Access: Network assignment](https://learn.microsoft.com/entra/identity/conditional-access/concept-assignment-network): named locations and trusted IPs, the fix identified but not yet built for the corporate-VPN false positive on the anonymized-IP signal

## Scripting disclaimer
The script in [`scripts/RiskInvestigation.ps1`](./scripts/RiskInvestigation.ps1)
reflects commands that were actually run against the tenant during
this lab. Written with AI assistance, reviewed and understood line by
line before running, consistent with standard practice of validating
any script before it touches a real environment.

## Still open
- The RiskDetail label mismatch documented in scenarios.md has not
  been independently re-tested to isolate the cause.
- No alert or automated response is wired to the KQL detection queries.
  They currently have to be run manually.
- Self-service remediation (user completes step-up MFA to clear their
  own risk) was never exercised, only the admin-forced path.
