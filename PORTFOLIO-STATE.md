# PORTFOLIO-STATE.md

**This is the anti-repeat ledger. Claude Code reads this before proposing ANY new lab.**

> ⚠️ CAM: fill in the "COMPLETED" table below with what you have ACTUALLY built.
> I do not have a reliable picture of your full portfolio, and I will not guess.
> Until this is filled in, `/lab-propose` will ask you to complete it first.
>
> Pull from: your Notion hub, your GitHub repo, and your website's project pages.
> One line each. Be honest — an inflated ledger produces bad lab proposals.

---

## COMPLETED — do not propose anything in this list again

Verified 2026-07-14 directly against the GitHub repo (`cama17/azure-iam-portfolio`,
pulled from a 3-commits-stale local clone), the website repo
(`cama17/camsjourneytosec`), and Notion. Not guessed from memory.

| # | Lab | Surface | What it proves | Artifacts | Frameworks mapped | Date |
|---|-----|---------|----------------|-----------|-------------------|------|
| 1 | Enterprise SSO — Zendesk + Entra ID (SAML) + Conditional Access (MFA) | Entra ID | Federated SAML SSO, CA-enforced MFA at token issuance, sign-in log validation | GitHub | none — flag for retrofit | unknown, verify |
| 2 | Okta SSO + Zendesk (SAML) | Okta | Second IdP, SP + IdP-initiated SAML flows | GitHub | none — flag for retrofit | Feb 2026 |
| 3 | Zendesk Provisioning via Entra ID | Entra ID | JML lifecycle via app provisioning (Entra → Zendesk) | GitHub | none — flag for retrofit | unknown, verify |
| 4 | Okta SCIM Provisioning + Zendesk | Okta | Full create/update/deactivate lifecycle via SCIM | GitHub | none — flag for retrofit | Mar 2026 |
| 5 | Stark Enterprise AD Lab | On-prem AD | Directory fundamentals, OUs, 15 users, hybrid-ready (Entra Connect) | GitHub | none — flag for retrofit | unknown, verify |
| 6 | Stark Enterprise Entra ID Lab (SC-300 aligned) | Entra ID | Hybrid identity, groups, dynamic groups, B2B, CA, PIM, **Entitlement Management + Access Reviews with a real break/restore cycle** (AADSTS50105 + AuditLogs + SigninLogs evidence), JML lifecycle workflows, Graph PowerShell (comparison only, not executed) | GitHub ✅ · Website ✅ (11 phase subpages) · Notion ✅ (rough draft) · LinkedIn drafted, not yet posted | **ISO 27001 A.5.18, SOC 2 CC6.2/CC6.3, NIST 800-53 AC-2(1)/(3), PCI DSS 7.2.1/7.2.4, GDPR Art. 32(1)(b), NIS2 Art. 21(2)(d)** | 2026-07-15 |
| 7 | Stark Enterprise Wise Integration | Azure + Entra ID | Secretless auth (Managed Identity + Key Vault RBAC), 4 real break/fix scenarios with captured error bodies + correlation IDs | GitHub ✅ · Website ✅ · Notion ❌ stale (still points at old private code repo, empty fields) · LinkedIn unconfirmed | none — flag for retrofit | unknown, verify |
| 8 | Stark Enterprise Identity Protection — Risk-Based Conditional Access + Microsoft Graph PowerShell | Entra ID | Risk-based CA scored against real-time sign-in risk; first Graph PowerShell in the portfolio actually connected and executed against a live tenant (least-privilege delegated scopes), not a side-by-side comparison; real break/restore (two independent AADSTS53004 blocks, discovered dismiss ≠ remediate the hard way); KQL detection queries against Log Analytics | GitHub ✅ · Website ✅ · Notion ✅ · LinkedIn posted | NIS2 Art. 21(2)(j), GDPR Art. 32(1)(d), ISO 27001 A.8.5/A.8.16, SOC 2 CC6.6/CC7.2, NIST 800-53 AC-2(12), NIST CSF 2.0 DE.CM-03 | 2026-07-17 |

**Project 06 has its own internal roadmap** (SC-300 phase table in its README) —
phases 1–11 are complete; phases 12–18 (Identity Governance/JML, Enterprise Apps/SCIM
beyond Zendesk, Salesforce SAML, Azure VM + Key Vault, Defender for Cloud Apps,
Sentinel/KQL, Secure Score) are self-marked **"Planned"**, not done. Don't propose
these as new standalone labs — they're already scoped as the next phases of Project 06.

**Notion tracker is out of sync with GitHub.** The Notion "Projects" database has
only 2 rows (AD Conversion/Rebuild, Enterprise Integration Entra+Wise) and neither
reflects current GitHub/website state. Low-priority backfill: update the Wise row's
GitHub Repo / Website Page fields, and add rows for Projects 1–4. Not a blocker.

### Retrofit opportunity
If a completed lab has **no compliance mapping**, that's a cheap high-value win.
Going back and adding a control-mapping table to an existing writeup costs an hour
and directly advances the thesis. Ask Claude for `/lab-retrofit`.

---

## CAPABILITY COVERAGE — where the real gaps are

Claude proposes labs that fill ❌ and ⚠️ rows, never ✅ rows.
Verified against actual repo/website content 2026-07-14 — not guessed.

| Capability | Status | Notes |
|---|---|---|
| SAML SSO | ✅ | Day-job + Projects 1, 2 |
| SCIM provisioning | ✅ | Projects 3, 4 |
| OAuth / OIDC | ⚠️ | Day-job exposure; no dedicated lab artifact |
| Conditional Access | ✅ | Project 1 (MFA enforcement) + Project 6 phases 9–10 (incl. strategy doc) |
| Identity Protection | ✅ | Project 8 — real risk-based CA, real `anonymizedIPAddress` detection triggered via a real Tor sign-in, real break/restore. Not a gap anymore. |
| **PIM / JIT elevation** | ✅ | Project 6 phase 11. Not a gap anymore — don't re-propose. |
| **Entitlement Mgmt (access packages)** | ✅ | Project 6 Phase 11. Two patterns built: self-service baseline + approval-gated contractor, the second proven under a real break/restore. Not a gap anymore. |
| **Access Reviews / certification** | ✅ | Project 6 Phase 11. Monthly contractor review + a second weekly review tied to the break-tested package. Not a gap anymore. |
| **Lifecycle Workflows (JML)** | ✅ | Project 6 Phase 11 — Joiner/Mover/Leaver, real screenshots. Correction: this was already built before 2026-07-15; the README's phase table had a stale "Planned" status that didn't match its own Documentation folder. Verify any other phase statuses in that table before trusting them at face value. |
| Dynamic groups / birthright | ✅ | Project 6 phase 4 |
| **Microsoft Graph PowerShell** | ✅ | Project 8 — connected and executed for real against `starkenterpriselab.com` for the first time, least-privilege delegated scopes (`IdentityRiskyUser.ReadWrite.All`, `IdentityRiskEvent.Read.All`), not the full `Microsoft.Graph` module. Queried and attempted remediation on a genuine flagged account. No longer the weakest area. |
| **KQL / Log Analytics** | ✅ | Project 8 — two real KQL queries against `AADUserRiskEvents`/`AADRiskyUsers`, extending the `governance-lab-logs` workspace. Project 6 phase 17 (broader Sentinel/KQL) is still separately self-scoped "Planned," but real KQL evidence now exists elsewhere in the portfolio. Note: Project 7 still uses Elastic/Kibana, which global CLAUDE.md says was deleted for cost hygiene in favor of Log Analytics + KQL — verify that Elastic Cloud resource isn't still billing |
| Workload identity / Managed Identity | ✅ | Project 7 — system-assigned MI, Key Vault RBAC, zero hardcoded creds, verified in depth |
| Okta federation (multi-IdP) | ❌ | Free (Okta Dev Edition). Untapped. |
| Okta → Entra SCIM | ❌ | Have Okta→Zendesk and Entra→Zendesk separately; no IdP-to-IdP |
| IaC (Bicep / Terraform) | ❌ | Sec Engineer signal |
| **Compliance control mapping** | ⚠️ | **← THE THESIS.** Project 6 Phase 11 and Project 8 now both have real control-ID tables with confidence levels stated honestly (including explicit "does NOT map" calls for PCI DSS/HIPAA on Project 8). Projects 1–5 and 7 still have none. Still the cheapest, highest-value retrofit available — ask Claude for `/lab-retrofit`. |
| **Break-and-restore w/ real captured error** | ✅ (Projects 6 Phase 11, 7, 8) | Projects 1–5 show config steps but no deliberate break/restore with captured real errors. Project 6 Phase 11, Project 7, and Project 8 all meet the CLAUDE.md bar now — use any of them as the template. |

---

## THE STORY SO FAR

*(Claude updates this at `/lab-close`. It is the argument the portfolio makes,
in order. If a lab doesn't advance the argument, it shouldn't be built.)*

**Act 1 — "I can wire identity systems together."**
> SAML, SCIM, OAuth. Federation works. Users flow.

**Act 2 — "I can govern access, not just grant it."**
> PIM, access packages, access reviews, JML. Least privilege, enforced and reviewed.

**Act 3 — "I can prove it to an auditor."**
> KQL evidence queries. Control mappings. Break-and-restore with real logs.

**Act 4 — "I can automate and scale it."**
> Graph PowerShell. IaC. The whole tenant, reproducible from code.

Current position: Act 2 is done. Access packages, access reviews, and JML
lifecycle workflows are all built (Project 6 Phase 11). Act 3 now has two
real examples: Project 6 Phase 11's entitlement break/restore with
AuditLogs/SigninLogs evidence, and Project 8's Identity Protection
break/restore with real KQL evidence against Log Analytics, both with full
compliance tables. Act 4 is no longer untouched — Project 8 connected and
ran Microsoft Graph PowerShell for real against the tenant for the first
time, investigating and attempting remediation on a genuinely flagged
account, not a side-by-side comparison. The one piece of Act 4 still
completely missing is Infrastructure as Code (Bicep/Terraform): the tenant
is still built by hand and by interactive script, not reproducible from a
repository. That's the honest ceiling now, not PowerShell exposure.

---

## NEXT UP (max 1 — no parallel labs)

_Nothing in progress. Closed 2026-07-17 — Project 8 (Risk-Based Conditional Access +
Microsoft Graph PowerShell, Identity Protection). Run `/lab-propose` to pick the next
lab. Two real open questions from the closed lab are worth a quick check before
starting something new, not a reason to reopen it: (1) why the admin-generated
temporary password produced `RiskDetail: userPerformedSecuredPasswordReset` instead of
the documented `adminGeneratedTemporaryPassword`, (2) whether a test account with real
prior sign-in history would self-remediate on a second, familiar-looking sign-in
without any admin action at all._
