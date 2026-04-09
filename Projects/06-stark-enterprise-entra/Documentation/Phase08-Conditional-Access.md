# Phase 08 - Conditional Access

## Objective
Implement Zero Trust access controls for Stark Enterprise using
Conditional Access policies. Require MFA for all users, block
legacy authentication protocols, and enforce risk-based access.

## SC-300 Alignment
- Lab 13: Implement and Test a Conditional Access Policy
- Lab 14: Enable Sign-in and User Risk Policies

## Accelerator Alignment
- Week 4: Enable MFA via Conditional Access
- Week 4: Block Legacy Authentication
- Week 4: CA Policy - Require MFA
- Week 4: Test CA Policies

## Policies Configured

| Policy | Grant Control | State |
|---|---|---|
| CA001 - Require MFA for All Users | Require MFA | On |
| CA002 - Block Legacy Authentication | Block access | On |
| CA003 - Sign-in Risk Policy | Require MFA | On |

## Policy Details

### CA001 - Require MFA for All Users
- Users: All users
- Target resources: All cloud apps
- Grant: Require multifactor authentication
- State: On

Every sign-in to any Stark Enterprise cloud app requires
MFA regardless of location or device.

### CA002 - Block Legacy Authentication
- Users: All users
- Target resources: All cloud apps
- Conditions: Client apps - Exchange ActiveSync and Other clients
- Grant: Block access
- State: On

Legacy protocols like POP3, IMAP, and SMTP do not support MFA.
Blocking them prevents attackers from bypassing MFA enforcement
by using older authentication methods.

### CA003 - Sign-in Risk Policy
- Users: All users
- Target resources: All cloud apps
- Conditions: Sign-in risk - High and Medium
- Grant: Require multifactor authentication
- State: On

When Entra ID detects a risky sign-in such as impossible travel
or leaked credentials, MFA is required automatically before
access is granted.

## What If Tool Test

Test scenario: Tony Stark signing in from a Windows browser
with no sign-in risk from an unknown location.

Results:
- CA001 - Require MFA for All Users - APPLIES - Require MFA
- CA002 - Block Legacy Authentication - APPLIES - Block access

This confirms both policies evaluate correctly. Tony Stark
would be required to complete MFA on every sign-in and any
attempt using legacy protocols would be blocked automatically.

## Design Decisions

**Why set policies to On instead of Report-only?**
In a lab environment with no production users there is no
risk of locking out real employees. Setting policies to On
provides stronger portfolio evidence that the controls are
active and enforced. In a production environment Report-only
would be used first for at least one week to review impact
before switching to On.

**Why block legacy authentication?**
Legacy protocols predate MFA and have no mechanism to support
it. An attacker with stolen credentials could use IMAP or SMTP
to authenticate successfully even with MFA policies active
for modern auth. Blocking legacy auth closes this gap entirely.

## Screenshots
- 01-ca-policies-overview.png
- 02-ca-block-legacy-auth.png
- 03-ca-whatif-test.png