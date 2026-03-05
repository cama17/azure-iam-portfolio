# Phase 8 - Entra ID Connect

## Objective
Connect the on-premises Active Directory environment to Microsoft
Entra ID using Entra Connect Sync, establishing a hybrid identity
infrastructure where all 15 AD users exist in both on-premises
and cloud environments.

## Environment Details
| Setting | Value |
|---|---|
| Tool | Microsoft Entra Connect Sync |
| Installed On | STARK-DC01 |
| On-Premises Domain | starkenterpriselab.com |
| Entra Tenant | starkenterpriselab.com |
| Admin Account | firstname.last@starkenterpriselab.com |
| Users Synced | 15 |
| Sync Type | Express Settings |

## What is Entra Connect
Entra Connect is a tool installed on the on-premises Domain
Controller that acts as a bridge between on-premises Active
Directory and Microsoft Entra ID in the cloud. Once configured
it automatically syncs AD users to Entra ID on a regular
30 minute schedule.

This creates hybrid identities - users that exist both
on-premises in Active Directory and in the cloud in Entra ID.
In a real enterprise this is how companies migrate from
purely on-premises identity to cloud identity without
disrupting existing users.

## Steps Completed

### 1. Added NAT Adapter to STARK-DC01
- Added a second network adapter set to NAT
- This gave STARK-DC01 internet access for the download
- Adapter 1 remained on Internal Network for VM communication
- Adapter 2 set to NAT for internet access

### 2. Downloaded Entra Connect Sync
- Navigated to https://entra.microsoft.com
- Identity - Hybrid Management - Microsoft Entra Connect
- Downloaded Connect Sync agent
- Note: Entra Connect is no longer available from the Microsoft
  Download Center - it must be downloaded from the Entra admin
  center directly

### 3. Installed Entra Connect Sync
- Ran the installer on STARK-DC01
- Selected Express Settings
- Entered Entra ID global admin credentials
- Entered on-premises AD credentials (STARKENTERPRISE\Administrator)
- Clicked Install and let the configuration complete

### 4. Verified Sync
- Navigated to Entra admin center - Identity - Users - All Users
- Confirmed all 15 AD users appeared in Entra ID
- Confirmed Tony Stark UPN shows tony.stark@starkenterpriselab.com
- Confirmed On-premises sync enabled shows Yes for synced users

## Design Decisions

**Why Express Settings?**
Express settings are appropriate for a single forest, single
domain environment like Stark Enterprise. It automatically
configures the sync with Microsoft recommended settings.
Custom settings are for complex enterprise scenarios with
multiple forests or special requirements.

**Why install on STARK-DC01?**
Entra Connect must be installed on a server that has access
to both the on-premises AD and the internet. STARK-DC01 is
the Domain Controller so it has full AD access. Adding a
NAT adapter gave it internet access for the sync.

**Why align the UPN to starkenterpriselab.com from the start?**
This was a deliberate decision made in Phase 0. The on-premises
UPN suffix matches the verified Entra ID custom domain. This
means users sync cleanly with no UPN remediation required.
If we had used an internal domain like stark.local, every
UPN would need to be changed before syncing.

**What is On-premises sync enabled: Yes?**
This field in Entra ID confirms the user account originated
from on-premises Active Directory and is being managed by
Entra Connect. It distinguishes synced users from cloud-only
users created directly in Entra ID.

## Authentication Flow - Hybrid Identity
After the sync, Tony Stark's identity exists in two places:
```
On-premises (STARK-DC01)          Cloud (Entra ID)
tony.stark@stark...com    <-->    tony.stark@stark...com
Managed via AD tools              Managed via Entra portal
Authenticates domain logins       Authenticates cloud app logins
```

Both identities stay in sync automatically every 30 minutes
via Entra Connect running on STARK-DC01.

## Verification Results
- Entra Connect installed and configured on STARK-DC01
- Express settings used for single forest environment
- 15 AD users confirmed in Entra ID All Users list
- Tony Stark UPN confirmed as tony.stark@starkenterpriselab.com
- On-premises sync enabled confirmed as Yes
- Hybrid identity successfully established

## Screenshots
- 01-entra-connect-download.png
- 02-entra-connect-welcome.png
- 03-entra-connect-setup-options.png
- 04-entra-connect-credentials.png
- 05-entra-connect-ad-credentials.png
- 06-entra-connect-ready.png
- 07-entra-connect-complete.png
- 08-entra-users-synced.png
- 09-tony-stark-entra-profile.png