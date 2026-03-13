# Phase 1: Review Synced Hybrid Users

## Objective
Validate the hybrid identity state of users synchronized from the on-premises Active Directory environment to Microsoft Entra ID.

## Core Concepts
* **Source of Authority:** For hybrid users, the on-premises Active Directory Domain Controller is the source of truth. 
* **Read-Only Cloud Attributes:** Core identity attributes (Name, Department, Job Title) cannot be edited directly in the Entra admin center. Changes must be made on-premises and synchronized via Microsoft Entra Connect.

## Execution
1. Navigated to `entra.microsoft.com` > **Identity** > **Users** > **All users**.
2. Verified the **On-premises sync enabled** status for all synced service accounts and employee accounts.
3. Attempted to edit the `Job Title` and `Department` properties for a synced user (Tony Stark).
4. Confirmed the Entra admin center blocks edits to these fields, displaying a warning that the user is synchronized from local Active Directory.

## Evidence
* `01-SyncedUsersList.png`: Shows the directory sync status of the hybrid users.
* `02-ReadOnlyProperties.png`: Shows the blocked ability to edit core attributes in the cloud.