# Phase 3 - Domain Controller Promotion

## Objective
Promote STARK-DC01 from a plain Windows Server into a fully
operational Domain Controller, creating the starkenterpriselab.com
Active Directory forest.

## Configuration Details
| Setting | Value |
|---|---|
| Deployment Operation | Add a new forest |
| Root Domain Name | starkenterpriselab.com |
| NetBIOS Name | STARKENTERPRISE |
| Forest Functional Level | Windows Server 2016 |
| Domain Functional Level | Windows Server 2016 |
| DNS Server | Installed automatically |
| Global Catalog | Enabled |

## Steps Completed

### 1. Launched Promotion Wizard
- Clicked Promote link from Server Manager yellow flag
- Selected Add a new forest
- Entered root domain name: starkenterpriselab.com

### 2. Domain Controller Options
- Set Forest Functional Level to Windows Server 2016
- Set Domain Functional Level to Windows Server 2016
- Confirmed DNS Server checkbox enabled
- Confirmed Global Catalog checkbox enabled
- Set DSRM password

### 3. DNS Options
- DNS delegation warning acknowledged
- Warning expected — no parent zone exists for a new forest

### 4. NetBIOS Name
- Auto-populated as STARKENTERPRISE
- Legacy short name for backwards compatibility

### 5. Database Paths
- Left all paths as default:
  - Database: C:\Windows\NTDS
  - Log files: C:\Windows\NTDS
  - SYSVOL: C:\Windows\SYSVOL

### 6. Prerequisites Check
- All prerequisites passed
- Yellow flags acknowledged as informational only

### 7. Installation & Reboot
- Promotion completed successfully
- Server rebooted automatically
- Login screen confirmed STARKENTERPRISE\Administrator

## Design Decisions

**Why Add a new forest?**
This is a brand new environment with no existing AD infrastructure.
A new forest creates a completely independent security boundary
for Stark Enterprises.

**Why Forest Functional Level 2016?**
Provides all modern AD features while maintaining maximum
compatibility. In a real enterprise this would be set to match
the oldest Domain Controller in the environment.

**What is the DSRM password?**
Directory Services Restore Mode is an emergency recovery password
used only if AD becomes corrupted and needs repair. Completely
separate from the Administrator password. In production this
would be stored in a privileged password vault.

**What is NTDS.dit?**
The actual Active Directory database file stored on the Domain
Controller. Contains all user accounts, groups, and policies
for the entire domain.

**What is SYSVOL?**
A special shared folder on the Domain Controller that stores
Group Policy files and scripts that need to be accessible
across the entire domain.

**Why did we use starkenterpriselab.com as the domain name?**
The domain name matches the verified custom domain registered
in Microsoft Entra ID. This alignment ensures clean hybrid
identity synchronization via Entra Connect without requiring
UPN remediation later.

## Verification
- Login screen showed STARKENTERPRISE\Administrator after reboot
- Active Directory Users and Computers opened successfully
- starkenterpriselab.com domain confirmed in ADUC
- Default containers verified: Builtin, Computers, Domain
  Controllers, ForeignSecurityPrincipals, ManagedServiceAccounts,
  Users

## Screenshots
- 01-DC-promotion-review.png
- 02-DC-promotion-script.png
- 03-prereq-checks.png
- 04-DC-server-manager.png
- 05-DC-login-screen.png
- 06-ADUC-first-view.png
- 07-ADUC-default-containers.png