# Phase 4 — Organizational Unit Structure

## Objective
Design and implement the organizational skeleton of Stark Enterprises
inside Active Directory using Organizational Units that reflect
real enterprise security segmentation principles.

## OU Structure
```
starkenterpriselab.com
├── Executives
├── Engineering
├── Security
├── Legal
├── Operations
└── ServiceAccounts
```

## Steps Completed

### 1. Enabled Advanced Features in ADUC
- View → Advanced Features
- Enables visibility of additional object properties
- Required to verify accidental deletion protection

### 2. Created 6 Organizational Units
- Right clicked starkenterpriselab.com
- Selected New → Organizational Unit
- Created each OU with protection enabled:
  - Executives
  - Engineering
  - Security
  - Legal
  - Operations
  - ServiceAccounts

### 3. Verified Accidental Deletion Protection
- Right clicked Executives OU → Properties → Object tab
- Confirmed Protect object from accidental deletion is checked
- Applied to all 6 OUs at creation time

## Design Decisions

**Why these 6 OUs?**
Each OU represents a functional department within Stark Enterprises.
This structure mirrors real enterprise AD design where OUs reflect
organizational boundaries for policy application purposes.

**Why not just use the default Users container?**
Group Policy Objects can only be applied to OUs — not to default
containers like the built-in Users folder. Using the default
container would make it impossible to apply department-specific
security policies to specific groups of users.

**Why does OU design matter beyond organization?**
OUs are policy application points. The structure determines how
granularly security controls can be applied. For example:
- Enforce stricter passwords on Executives only
- Disable USB ports for Engineering only
- Apply different login hour restrictions per department

**Why a dedicated ServiceAccounts OU?**
Service accounts are non-interactive accounts used by systems,
applications, and automated scripts. They are fundamentally
different from human accounts and require:
- Stricter security policies
- Separate password management and rotation schedules
- Isolated monitoring for security auditing
- Protection from accidental modification by user admins

**Why enable accidental deletion protection?**
In a real enterprise, accidentally deleting an OU containing
hundreds of users would be catastrophic and potentially
irreversible without a backup restore. This protection forces
a deliberate two-step process before any OU can be deleted.

## Security Principles Applied
- Separation of Duties - service accounts isolated from human accounts
- Least Privilege - granular policy application per department
- Defense in Depth - accidental deletion protection on all OUs

## Verification
- All 6 OUs visible in ADUC under starkenterpriselab.com
- Accidental deletion protection confirmed on Executives OU
- Advanced Features enabled for full object visibility

## Screenshots
- 01-OU-structure.png
- 02-OU-protection-verified.png
- 03-OU-advanced-view.png