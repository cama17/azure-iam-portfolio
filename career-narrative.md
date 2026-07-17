# career-narrative.md

**This is the argument the portfolio makes, not a changelog.** Each entry
below is a claim CAM can now defend in an interview, in order of when it
became true. If a lab doesn't add a new claim here, it didn't need to be built.

---

## 2026-07-15 — Project 6, Phase 11: Entitlement Management and Access Reviews

**The claim CAM could not make before this lab:**
CAM could say "I've configured Conditional Access and PIM." CAM could not say
"I've built a governed access request workflow and proven the control holds
under a real failure, not just that the config screen saved."

**Which Act this advanced:**
Act 2 ("I can govern access, not just grant it") is now fully built out:
access packages, access reviews, and JML lifecycle workflows all exist with
real evidence. This lab also put a first real toe into Act 3 ("I can prove it
to an auditor") outside of Project 7: a genuine break/restore cycle with
AuditLogs and SigninLogs evidence, plus a full compliance control-mapping
table with honestly-stated confidence levels.

**The strongest sentence CAM can now say in an interview, verbatim:**
> "I built an approval-gated access package, then removed a live assignment
> to see what actually enforces the block. The error was AADSTS50105, and the
> sign-in log's ConditionalAccessStatus field still read success on that same
> line, which is what told me the block was entitlement enforcement, not
> Conditional Access. Those are two different controls in this tenant, and
> the log told me which one fired instead of me having to guess."

**What CAM learned that was not in the plan:**
The plan was to test the access review's own auto-remove-on-no-response
action as the break. In practice, the review sat at "Not started" for
roughly 24 hours past its scheduled start, so the break that actually
happened was a manual admin removal, a related but different mechanism. That
gap turned into a real, documented finding (an unexplained activation
latency) instead of a filled-in blank, which is the more honest outcome.

Separately, CAM initially conflated two governance concepts under pressure in
`/lab-defend`, calling the one-time approval step an "access review," when an
access review is a completely separate, calendar-triggered recertification
mechanism that runs whether or not anyone requested anything that week.
That distinction is the actual SailPoint-concept differentiator this lab
was built to prove, so getting it wrong once, out loud, under a skeptical
question, was worth catching before an interview did it instead.

**Named gap going into the next lab:**
CAM now has three governance-flavored labs (PIM, Entitlement Management,
Access Reviews) built entirely by hand in the Entra admin center portal.
Every Graph PowerShell shown alongside any of them has been a side-by-side
comparison for learning, never something actually executed against the
tenant. That's the honest ceiling right now, not access governance depth.
The next lab should be the one where CAM runs real Graph PowerShell against
the tenant, reviewed and understood line by line, not just read alongside a
portal click, or the portfolio plateaus as "competent clicker" instead of
crossing into automation, which is exactly the gap Act 4 exists to close.

---

## 2026-07-17 — Project 8: Risk-Based Conditional Access + Microsoft Graph PowerShell (Identity Protection)

**The claim CAM could not make before this lab:**
CAM could say "I've configured Conditional Access policies and compared
Graph PowerShell commands to portal clicks." CAM could not say "I've
connected to a live tenant with Microsoft Graph PowerShell, investigated a
real flagged account, and found out my own remediation attempt didn't
actually work." This is the first lab in the whole portfolio where
PowerShell was executed for real, not shown side by side with the portal.

**Which Act this advanced:**
This closes the exact gap named at the end of the Project 6 Phase 11 entry
above. Act 4 ("I can automate and scale it") now has its first real toe in:
Graph PowerShell actually connected and run against `starkenterpriselab.com`,
using least-privilege delegated scopes, not the full `Microsoft.Graph`
module. It also extends Act 3 ("I can prove it to an auditor") with genuine
KQL queries against Log Analytics and a second real break/restore cycle,
this time inside Identity Protection rather than entitlement management.

**The strongest sentence CAM can now say in an interview, verbatim:**
> "I dismissed a risky user through Graph PowerShell. The command returned
> True, and the record showed dismissed. It still didn't fix anything — a
> second sign-in from a different network hit the identical AADSTS53004
> block, because dismissing a risk clears the flag but doesn't touch the
> reason the account couldn't self-remediate, which in this case was zero
> MFA methods registered. The actual fix had to be an admin-generated
> temporary password, and even that produced a RiskDetail label that
> doesn't match what Microsoft's own documentation says it should say,
> which I've flagged as unresolved instead of papering over."

**What CAM learned that was not in the plan:**
The plan assumed one clean break/restore cycle. Instead, the first block
came from a pre-existing policy (`CA003`) nobody had validated before, not
the new lab policy, which was still passively observing in Report-only.
Dismissing the risk looked like success, a clean `True` return and
`RiskState: dismissed`, and it didn't restore access; a second real block
on the second sign-in attempt is what surfaced that dismiss and remediate
are two structurally different actions. The RiskDetail label produced by
the actual fix (`userPerformedSecuredPasswordReset`) also contradicts
Microsoft's own documented mapping for that exact admin action
(`adminGeneratedTemporaryPassword`), a genuine unresolved discrepancy,
confirmed against real Microsoft Learn documentation, not a manufactured
one.

**Named gap going into the next lab:**
Graph PowerShell is no longer the gap. What's left of Act 4 is Infrastructure
as Code: every lab in this portfolio, including this one, was still built by
hand in the portal or by interactive script typed one command at a time.
None of it is reproducible from a repository. The next lab should be the one
where CAM defines tenant configuration (Conditional Access policies, groups,
diagnostic settings) in Bicep or Terraform and actually deploys from it, or
the portfolio plateaus at "can run a script someone hands me" instead of
crossing into "can build infrastructure that survives without me clicking
through it again," which is what closes Act 4 for good.
