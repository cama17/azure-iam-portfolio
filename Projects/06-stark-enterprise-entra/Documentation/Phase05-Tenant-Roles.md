# Phase 05 - Tenant Properties and Roles

## Objective
Configure Stark Enterprise tenant properties and assign
least-privilege admin roles to users based on their job functions.

## SC-300 Alignment
- Lab 01: Manage User Roles
- Lab 02: Working with Tenant Properties

## Accelerator Alignment
- Week 2: Explore Entra Portal - Roles
- Week 3: Review Built-in Admin Roles and Assign Least Privilege

## Tenant Properties Configured

| Setting | Value |
|---|---|
| Display Name | Stark Enterprise Lab |
| Technical Contact | user.example@starkenterpriselab.com |
| Privacy Contact | user.example@starkenterpriselab.com |

## Role Assignments

| User | Role | Assignment Type | Rationale |
|---|---|---|---|
| Phil Coulson | User Administrator | Active | IT Manager requires user and group management |
| Nick Fury | Security Reader | Active | Security Manager requires read-only security visibility |

## Design Decisions

**Why User Administrator for Phil Coulson and not Global Admin?**
Phil Coulson's job as IT Manager requires managing user accounts
and groups. User Administrator gives him exactly that scope.
Global Administrator would give him full control over all tenant
settings including billing, security policies, and app registrations
- none of which his role requires. Least privilege is applied.

**Why Security Reader for Nick Fury and not Security Administrator?**
Nick Fury needs visibility into security events and reports as
Security Manager. Security Reader gives him read-only access to
all security information. Security Administrator would allow him
to modify security policies and settings - not required for his role.

**Why Active assignments instead of Eligible?**
Active assignments were used to demonstrate role assignment and
least privilege in this phase. Eligible assignments with PIM
just-in-time activation are covered in Phase 11 where the full
PIM workflow is configured and tested.

## Built-in Admin Roles Overview

| Role | Scope |
|---|---|
| Global Administrator | Full control of all tenant settings |
| User Administrator | Create and manage users and groups |
| Groups Administrator | Manage groups only |
| Security Reader | Read-only view of security settings |
| Helpdesk Administrator | Reset passwords only |
| Security Administrator | Configure security policies |

## Verification
- Tenant display name confirmed as Stark Enterprise Lab
- Phil Coulson Assigned roles shows User Administrator
- Nick Fury Assigned roles shows Security Reader

## Screenshots
- 01-tenant-properties.png
- 02-admin-roles-list.png
- 03-phil-coulson-user-admin.png
- 04-nick-fury-security-reader.png