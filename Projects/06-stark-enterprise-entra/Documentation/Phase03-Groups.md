# Phase 03 - Groups and Licensing

## Objective
Create all Stark Enterprise security groups, assign users to the
correct groups, and configure group-based licensing so Microsoft
365 licenses are assigned automatically through group membership.

## SC-300 Alignment
- Lab 01: Manage User Roles
- Lab 03: Assign Licenses Using Group Membership

## Accelerator Alignment
- Week 2: Create Cloud Users and Groups
- Week 6: Configure Group-Based Licensing

## Users Created via Bulk Import
Four cloud-only users were created using the Entra ID bulk import
CSV feature before group membership could be assigned:

| Name | UPN | Department |
|---|---|---|
| Sharon Carter | sharon.carter@starkenterpriselab.com | HR |
| Sam Wilson | sam.wilson@starkenterpriselab.com | Operations |
| Bucky Barnes | bucky.barnes@starkenterpriselab.com | Operations |
| JARVIS | jarvis@starkenterpriselab.com | Vendor |

Note: JARVIS was created as an internal Member account with a
starkenterpriselab.com UPN for lab purposes. In a production
environment, a vendor support account would be invited as a
B2B Guest using their own external email address.

## Security Groups Created

| Group | Type | Membership | Purpose |
|---|---|---|---|
| SG-Security | Security | Assigned | Security department access |
| SG-IT | Security | Assigned | IT department access |
| SG-HR | Security | Assigned | HR department access |
| SG-Engineering | Security | Assigned | Engineering department access |
| SG-Operations | Security | Assigned | Operations department access |
| SG-Contractors | Security | Assigned | External contractor access |
| SG-All-Employees | Security | Assigned | All internal staff licensing |
| SG-Privileged-Eligible | Security | Assigned | PIM role eligibility |

## Group Membership

| Group | Members |
|---|---|
| SG-Security | Nick Fury, Natasha Romanoff |
| SG-IT | Phil Coulson, Peter Parker |
| SG-HR | Maria Hill, Sharon Carter |
| SG-Engineering | Tony Stark, Bruce Banner, Shuri |
| SG-Operations | Steve Rogers, Sam Wilson, Bucky Barnes, Happy Hogan, Pepper Potts |
| SG-Contractors | Logan, JARVIS |
| SG-All-Employees | All 16 internal users |
| SG-Privileged-Eligible | user.example@starkenterpriselab.com |

Note: Jennifer Walters and Matt Murdock are Legal department users
synced from on-premises AD. There is no SG-Legal group in this
design. Both users are members of SG-All-Employees only.

## Group Design Decisions

**Why no SG-Legal group?**
The Legal department has only 2 users. No specific Conditional
Access policies, app assignments, or governance workflows are
scoped to Legal in this project. Both users are included in
SG-All-Employees for licensing coverage.

**Why is SG-Contractors separate from SG-All-Employees?**
Contractors require different access controls, different licensing,
different Conditional Access policies, and separate access review
schedules. Mixing contractors with employees in the same group
creates security risk - a contractor could inherit employee access
by accident. Separation is a security boundary not just an
organisational label.

**Why is SG-Privileged-Eligible scoped to the admin account only?**
This group is reserved for PIM role eligibility in Phase 11. Only
accounts that require elevated admin access should ever be in this
group. Adding regular users here would violate least privilege.

**Why Assigned groups rather than Dynamic groups?**
Assigned groups give deliberate control over membership at this
stage. Dynamic groups are covered separately in Phase 04 where
attribute-based rules are configured and tested.

## Group-Based Licensing

Microsoft Power Automate Free was assigned to SG-All-Employees.

> **Lab licensing note:** Group-based licensing was configured
> using Microsoft Power Automate Free due to lab tenant licensing
> constraints. Only 1 seat of Microsoft 365 Business Basic and
> 1 seat of Entra ID P2 were available, both already assigned to
> the admin account. The Microsoft 365 Developer Program E5
> sandbox was not available for this tenant. In a production
> environment, Microsoft 365 E5 or equivalent would be assigned
> to department groups. The configuration process and concept are
> identical regardless of which license product is used.

### How Group-Based Licensing Works
When a user is added to SG-All-Employees they automatically
receive the assigned license. When a user is removed from the
group the license is removed automatically. No manual license
assignment is required per user.

This directly supports the Joiner process - when a new employee
is provisioned and added to their department group and
SG-All-Employees, licensing happens without any additional
admin action.

## Verification

- All 8 SG- groups confirmed in Entra ID All Groups list
- Group membership counts verified:
  - SG-Security: 2 members
  - SG-IT: 2 members
  - SG-HR: 2 members
  - SG-Engineering: 3 members
  - SG-Operations: 5 members
  - SG-Contractors: 2 members
  - SG-All-Employees: 16 members
  - SG-Privileged-Eligible: 1 member
- Power Automate Free license assigned to SG-All-Employees
- Tony Stark confirmed receiving license via group assignment

## Screenshots
- 01-existing-groups.png
- 02-SG-Security-created.png
- 03-all-SG-groups-created.png
- 04-SG-Security-members.png
- 05-SG-IT-members.png
- 06-SG-HR-members.png
- 07-SG-Engineering-members.png
- 08-SG-Operations-members.png
- 09-SG-Contractors-members.png
- 10-SG-All-Employees-members.png
- 11-SG-Privileged-Eligible-members.png
- 12-licensing-assignment.png
- 13-tony-stark-license.png