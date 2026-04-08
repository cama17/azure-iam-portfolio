# Phase 07 - Security Baseline - MFA and SSPR

## Objective
Configure the Stark Enterprise security baseline by enabling
Smart Lockout, MFA Registration Policy, and Self-Service
Password Reset (SSPR).

## SC-300 Alignment
- Lab 08: Enable Multi-Factor Authentication
- Lab 09: Enable Self-Service Password Reset
- Lab 12: Manage Smart Lockout Values
- Lab 15: Configure MFA Registration Policy

## Accelerator Alignment
- Week 4: Enable MFA
- Week 4: Test CA Policies (partial)

## Configuration Summary

| Feature | Setting | Value |
|---|---|---|
| Smart Lockout | Lockout threshold | 5 failed attempts |
| Smart Lockout | Lockout duration | 120 seconds |
| MFA Registration Policy | Scope | SG-All-Employees |
| MFA Registration Policy | Status | Enabled |
| SSPR | Scope | SG-All-Employees |
| SSPR | Methods required | 1 |

## Smart Lockout

Smart Lockout was configured under Protection ->
Authentication methods -> Password protection.

Reducing the threshold from 10 to 5 means accounts lock
faster when someone attempts a brute force attack.
Increasing the duration from 60 to 120 seconds means
attackers wait longer between attempts making automated
scripts significantly less effective.

## MFA Registration Policy

The MFA registration policy was scoped to SG-All-Employees
and set to Enabled. This prompts all internal Stark Enterprise
users to register their MFA method on their next sign-in.

Note: This policy registers users for MFA. It does not
enforce MFA on every sign-in. MFA enforcement is handled
through Conditional Access policies in Phase 09.

## SSPR

SSPR was enabled for SG-All-Employees. All internal staff
can reset their own passwords without contacting the helpdesk.

Authentication methods for SSPR are managed through the
centralized Authentication methods policy. Email OTP and
SMS are both enabled for users.

SSPR was successfully tested using Steve Rogers
(steve.rogers@starkenterpriselab.com) as a cloud-only user.
The reset flow completed successfully.

## Password Writeback - Hybrid Limitation

> SSPR for hybrid users synced from on-premises AD requires
> password writeback to be configured on Entra Connect.
> Without writeback, password changes in the cloud cannot
> sync back to the on-premises AD database on STARK-DC01.
>
> Phil Coulson is a hybrid user. When SSPR was tested with
> his account the following error appeared:
> "Password writeback isn't turned on for your organization"
>
> SSPR scope was updated to SG-All-Employees and tested
> successfully with Steve Rogers (cloud-only user).
>
> Password writeback requires:
> 1. Enabling writeback in the Entra Connect wizard on STARK-DC01
> 2. Enabling in Entra portal under Protection ->
>    Password reset -> On-premises integration
>
> This is documented as a future enhancement for when
> STARK-DC01 is available.

## Screenshots
- 01-smart-lockout.png
- 02-mfa-registration-policy.png
- 03-sspr-properties.png
- 03-sspr-properties-updated.png
- 04-sspr-auth-methods.png
- 05-sspr-test.png