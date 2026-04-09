# Phase 09 - Privileged Identity Management

## Objective
Implement just-in-time privileged access for Stark Enterprise
by converting the Global Administrator role from a permanent
Active assignment to an Eligible assignment requiring activation
through PIM.

## SC-300 Alignment
- Lab 11: Assign Azure Resource Roles in PIM
- Lab 26: Configure PIM for Entra Roles

## Accelerator Alignment
- Week 3: Enable PIM
- Week 3: Configure PIM JIT Settings
- Week 3: Test PIM Activation

## Configuration

| Setting | Value |
|---|---|
| Role | Global Administrator |
| Assignment type | Eligible |
| Eligibility duration | 1 year |
| Maximum activation duration | 4 hour |
| Require justification | Yes |
| Require approval | No |

## What Was Done

### Eligible Assignment Created
The admin account was made Eligible for Global Administrator.
This means the account does not have active admin rights until
the role is explicitly activated through the PIM workflow.

### PIM Settings Configured
Maximum activation duration set to 4 hour. Justification
required on every activation. This ensures every elevation
is intentional, documented, and time-limited.

### Activation Test
Role was activated successfully with the justification:
"Testing PIM activation for Stark Enterprise lab"

The role showed as Active and full admin access was confirmed.
After 1 hour the role expired automatically and access returned
to standard user level.

### Role Deactivated
Role was manually deactivated after testing to confirm the
deactivation workflow. The audit log captured the deactivation
event with timestamp.

## Audit Log Evidence

Every PIM action was captured in the audit log:

| Action | Result |
|---|---|
| Add eligible member to role | Logged |
| Update role setting in PIM | Logged |
| Add member to role request | Logged |
| Add member to role complete | Logged |
| Remove member from role | Logged |

This provides complete audit evidence that no permanent admin
access exists and every elevation is tracked with requestor,
timestamp, justification, and duration.

## Design Decisions

**Why Eligible instead of Active?**
Permanent admin access means a compromised account has unlimited
access forever. Eligible access limits the blast radius - even
a compromised account has no active admin rights. The attacker
would need to go through the PIM activation workflow which
requires justification and generates an audit alert.

**Why 4 hour maximum activation?**
Admin tasks rarely require more than 4 hour of elevated access.
Short activation windows reduce the time window an attacker
has to exploit a compromised session. In production this
would be tuned to match real operational requirements.

**Why require justification but not approval?**
Justification creates a paper trail for every elevation without
adding friction that would slow down legitimate admin work.
Approval would require a second person to approve every
activation which is appropriate for production but impractical
for a single-admin lab environment.

## Screenshots
- 01-pim-eligible-assignment.png
- 02-pim-role-settings.png
- 03-pim-activation.png
- 04-pim-audit-log.png
- 05-pim-deactivated.png