# Phase 11 - Identity Governance and JML

## Objective
Implement identity governance controls for Stark Enterprise
including Terms of Use, entitlement management, access reviews,
external user lifecycle, and Joiner Mover Leaver lifecycle
workflows.

## SC-300 Alignment
- Lab 22: Create and Manage a Catalog in Entitlement Management
- Lab 23: Add Terms of Use and Acceptance Reporting
- Lab 24: Manage Lifecycle of External Users
- Lab 25: Creating Access Reviews for Internal and External Users

## Accelerator Alignment
- Week 7: New Hire Workflow Design and Build
- Week 10: Access Package for Contractor Role

## What Was Configured

### Terms of Use
Created Stark Enterprise Acceptable Use Policy using the SC-300
sample PDF. Users must expand and read before accepting. Consent
expires monthly requiring re-acceptance.

CA004 created to enforce Terms of Use. Scoped to Steve Rogers
as test user. Steve was prompted to accept on next sign-in and
acceptance was confirmed in the report.

### Entitlement Management
Created Stark Enterprise Catalog as the container for all
access packages. SG-All-Employees added as a resource.

### Access Package - Stark Enterprise Baseline Access
Created inside Stark Enterprise Catalog. All internal members
excluding guests can self-request. No approval required.
Access expires after 90 days requiring renewal.

Note: Self-request was not visible to Steve Rogers initially
because the Self checkbox was not enabled in the policy. After
enabling Self under Who can request access the package appeared
correctly at myaccess.microsoft.com.

### External User Lifecycle (Lab 24)
Configured under Identity Governance -> Entitlement management
-> Settings:

| Setting | Value |
|---|---|
| Block external user from signing in | Yes |
| Remove external user | Yes |
| Days before removing external user | 30 |

### Access Review - Stark Contractor Access Review (Lab 25)
Monthly resource review for SG-Contractors. Nick Fury is the
reviewer with a 7 day duration. Auto-apply results enabled.
If Nick Fury does not respond within 7 days access is removed
automatically ensuring contractor access is certified monthly.

### Lifecycle Workflows

**Joiner - Stark Enterprise New Hire Onboarding**
Template: Onboard new hire employee
Trigger: employeeHireDate
Scope: userType equals Member
Tasks:
- Enable User Account
- Send Welcome email
- Add user to SG-All-Employees

New hires are automatically enabled, welcomed, and added to
baseline groups on their hire date. No admin action required.

**Mover - Stark Enterprise Department Mover**
Template: Employee job profile change
Trigger: department attribute change
Tasks:
- Send email to notify manager of user move
- Remove user from SG-Engineering

When an employee changes departments their manager is notified
and they are removed from their old department group
automatically. This eliminates manual group management during
role changes.

**Leaver - Stark Enterprise Employee Offboarding**
Template: Offboard an employee
Trigger: employeeLeaveDate
Scope: userType equals Member
Tasks: Disable account, remove group memberships,
notify manager

Access is revoked on the last day automatically without
relying on manual processes or IT tickets.

## Why JML Automation Matters

Manual JML processes fail because people forget steps.
Automated workflows ensure access is provisioned on day one
and revoked on the last day without IT tickets. This reduces
security risk and IT overhead simultaneously.

## Screenshots
- 01-terms-of-use-created.png
- 02-ca-tou-policy.png
- 03-tou-acceptance-prompt.png
- 04-tou-acceptance-report.png
- 05-catalog-created.png
- 06-catalog-resources.png
- 07-access-package-created.png
- 08-access-package-request.png
- 09-external-user-lifecycle.png
- 10-access-review-created.png
- 11-joiner-workflow.png
- 12-leaver-workflow.png
- 13-mover-workflow.png