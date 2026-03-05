# Phase 5 — User Account Creation

## Objective
Create 15 user accounts across 6 Organizational Units following
enterprise naming conventions and identity lifecycle management
principles.

## Naming Convention
| Component | Standard |
|---|---|
| Format | firstname.lastname |
| UPN Suffix | @starkenterpriselab.com |
| Display Name | First Last |
| Example | tony.stark@starkenterpriselab.com |

## User Accounts

### Executives
| Name | UPN | Account Type |
|---|---|---|
| Tony Stark | tony.stark@starkenterpriselab.com | User |
| Pepper Potts | pepper.potts@starkenterpriselab.com | User |

### Engineering
| Name | UPN | Account Type |
|---|---|---|
| Bruce Banner | bruce.banner@starkenterpriselab.com | User |
| Peter Parker | peter.parker@starkenterpriselab.com | User |
| Shuri | shuri@starkenterpriselab.com | User |

### Security
| Name | UPN | Account Type |
|---|---|---|
| Nick Fury | nick.fury@starkenterpriselab.com | User |
| Maria Hill | maria.hill@starkenterpriselab.com | User |
| Natasha Romanoff | natasha.romanoff@starkenterpriselab.com | User |

### Legal
| Name | UPN | Account Type |
|---|---|---|
| Jennifer Walters | jennifer.walters@starkenterpriselab.com | User |
| Matt Murdock | matt.murdock@starkenterpriselab.com | User |

### Operations
| Name | UPN | Account Type |
|---|---|---|
| Happy Hogan | happy.hogan@starkenterpriselab.com | User |
| Phil Coulson | phil.coulson@starkenterpriselab.com | User |

### ServiceAccounts
| Name | UPN | Purpose |
|---|---|---|
| svc-entra | svc-entra@starkenterpriselab.com | Entra ID Connect sync |
| svc-backup | svc-backup@starkenterpriselab.com | Backup operations |
| svc-monitoring | svc-monitoring@starkenterpriselab.com | System monitoring |

## Account Configuration
| Setting | Value | Rationale |
|---|---|---|
| Password | Stark@User2024! | Meets complexity requirements |
| Service Account Password | Stark@Svc2024! | Separate standard for service accounts |
| Password Never Expires | True | Lab convenience — prevents lockouts during testing |
| User Must Change Password | False | Lab environment setting |
| Account Status | Enabled | Required for Phase 6 authentication testing |

## Design Decisions

**Why firstname.lastname format?**
This is the most common enterprise UPN standard. It is human
readable, consistent, and aligns with the verified Entra ID
domain for clean hybrid identity synchronization.

**Why do service accounts have a separate password?**
In production, service account passwords are managed separately
from human accounts. They are rotated on different schedules
and stored in privileged password vaults. Using a separate
password standard here reflects that real world practice.

**Why are accounts enabled at creation?**
In a lab environment accounts need to be active for testing.
In production the best practice is the joiner process:
- Create account in disabled state
- Activate only when employee start date arrives
- This aligns with Zero Trust principles

**Why password never expires in the lab?**
In production passwords should expire on a regular cycle
typically 90 days to limit the window of exposure if a
password is compromised. Password history policies prevent
reuse of old compromised passwords. In a lab, expiring
passwords interrupt testing workflows.

**How would access control work at scale?**
Permissions are assigned to Security Groups not individual
users. Users are added to groups. When someone changes
departments they move between groups. Individual permission
assignment does not scale beyond small environments.

**How are edge cases like single name users handled?**
Single name accounts like Shuri can cause duplicate conflicts
at scale. The enterprise solution is appending a unique
employee ID to the username — for example shuri.001. This
is sourced from HR systems that assign unique IDs at hire.

## Verification
- All 15 accounts confirmed via Get-ADUser PowerShell command
- OU placement verified via DistinguishedName attribute
- Account health confirmed: Enabled True, LockedOut False

## Screenshots
- 01-user-tony-stark.png
- 02-ou-executives.png
- 03-ou-engineering.png
- 04-ou-security.png
- 05-ou-legal.png
- 06-ou-operations.png
- 07-ou-serviceaccounts.png