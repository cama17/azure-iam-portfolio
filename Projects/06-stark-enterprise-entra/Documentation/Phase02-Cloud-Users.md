# Phase 2: Internal Users & B2B Collaboration

## Objective
Create a cloud-only internal identity and invite an external B2B guest user to demonstrate the difference in Source of Authority and lifecycle management within Microsoft Entra ID.

## Core Concepts
* **Cloud-Only Users (Members):** Microsoft Entra ID is the absolute Source of Authority. The organization manages the password, MFA registration, and lifecycle of the account.
* **B2B Guest Users (External):** The Source of Authority remains with the user's home identity provider (e.g., another Entra ID tenant or a personal email provider). The host organization does not manage their credentials, which drastically reduces IT overhead while still allowing the host to enforce Conditional Access policies on its own resources.

## Execution
1. Navigated to `entra.microsoft.com` > **Identity** > **Users** > **All users**.
2. Created a new cloud-only user (`steve.rogers@starkenterpriselab.com`) and assigned the **Operations Manager** job title.
3. Invited an external user (`Logan`) using a personal email address and configured their User Type as **Guest**.
4. Validated the user list to confirm the difference in **Creation type** and **User type** between the two accounts.

## Evidence
* `Phase02-CloudAndGuestUsers.png`: Displays the new users created, highlighting the distinction between the internal Member account (Steve Rogers) and the external Guest account (Logan).