# Hybrid Identity Fix - Password Hash Sync and Writeback

## Overview
After enabling Conditional Access policies in Phase 08, hybrid
users synced from on-premises AD could not authenticate to cloud
resources. This document covers the root cause, fix, and
verification of the issue.

## Root Cause

Password Hash Synchronization was not enabled during the initial
Entra Connect configuration in Project 03. The Entra Connect
wizard was run while STARK-DC01 did not have internet access,
which caused credential validation errors and prevented optional
features from being saved correctly.

Without PHS, Entra ID has no way to verify the passwords of
hybrid users. The accounts exist as synced objects in Entra ID
but cannot authenticate to cloud resources.

## Symptoms
Error 53003 when AD users attempted to sign in
Affected users: Tony Stark, Phil Coulson, Nick Fury
and all other hybrid users synced from AD
Cloud-only users (Steve Rogers) were not affected

## Fix Applied

### Step 1 - Reconnect STARK-DC01 with internet access
STARK-DC01 was previously on Internal Network only for
VM-to-VM communication. Internet connectivity was confirmed
before running the Entra Connect wizard.

### Step 2 - Enable optional features in Entra Connect
The Entra Connect configuration wizard was run on STARK-DC01
with the following optional features enabled:

| Feature | Status |
|---|---|
| Password Hash Synchronization | Enabled |
| Password Writeback | Enabled |
| Group Writeback | Enabled |

### Step 3 - Enable writeback in Entra portal
Under Protection -> Password reset -> On-premises integration:
- Write back passwords to your on-premises directory: Yes
- Allow users to unlock accounts without resetting password: Yes

### Step 4 - Force full sync
```powershell
Start-ADSyncSyncCycle -PolicyType Initial
```

## Verification

Sign-in logs confirmed successful authentication for hybrid users
after the fix. Tony Stark and Phil Coulson both signed in to
MyApps successfully with Conditional Access showing Success.

## Why PHS Matters

Password Hash Synchronization syncs a hash of each user's
on-premises AD password to Entra ID. This allows Entra ID to
verify hybrid user credentials without needing a live connection
back to the on-premises Domain Controller for every sign-in.

## Why Password Writeback Matters

Password Writeback allows password changes made in the cloud
(via SSPR) to sync back to on-premises AD automatically. Without
it SSPR only works for cloud-only users. With it enabled all
users regardless of whether they are hybrid or cloud-only can
reset their own passwords.
