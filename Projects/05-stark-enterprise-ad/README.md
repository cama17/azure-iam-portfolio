# Stark Enterprise Active Directory Lab

## Project Overview
Designed and implemented a production-ready on-premises Active Directory 
environment for a fictional enterprise organization — Stark Enterprises. 
This project demonstrates core Identity and Access Management (IAM) 
principles including identity lifecycle management, security segmentation, 
and cloud-ready architecture.

## Business Context
Stark Enterprises required a centralized identity infrastructure to manage 
15 users across 6 departments. The environment was architected to align with 
Microsoft IAM best practices and structured for future hybrid identity 
integration with Microsoft Entra ID.

## Technical Environment
| Component | Details |
|---|---|
| Server OS | Windows Server 2022 Standard |
| Domain | starkenterpriselab.com |
| Domain Controller | STARK-DC01 |
| Static IP | 192.168.1.10 |
| Forest Functional Level | Windows Server 2016 |
| Virtualization | Oracle VirtualBox |

## What Was Built
- ✅ Windows Server 2022 Domain Controller (STARK-DC01)
- ✅ New Active Directory Forest —> starkenterpriselab.com
- ✅ 6 Organizational Units representing company departments
- ✅ 15 user accounts with standardized UPN naming convention
- ✅ Service accounts isolated in dedicated OU
- ✅ Accidental deletion protection on all OUs
- ✅ DNS configured and verified
- ✅ Environment verified via PowerShell

## Organizational Structure
```
starkenterpriselab.com
├── Executives        (Tony Stark, Pepper Potts)
├── Engineering       (Bruce Banner, Peter Parker, Shuri)
├── Security          (Nick Fury, Maria Hill, Natasha Romanoff)
├── Legal             (Jennifer Walters, Matt Murdock)
├── Operations        (Happy Hogan, Phil Coulson)
└── ServiceAccounts   (svc-entra, svc-backup, svc-monitoring)
```

## Key Design Decisions
| Decision | Rationale |
|---|---|
| UPN aligned to starkenterpriselab.com | Matches registered Entra ID domain for clean hybrid sync |
| Static IP 192.168.1.10 | DNS records must always resolve to correct DC address |
| DNS pointing to 127.0.0.1 | DC runs its own DNS — loopback ensures self-resolution |
| Forest Functional Level 2016 | Modern features with maximum compatibility |
| ServiceAccounts OU isolated | Non-human accounts require separate policy and audit controls |
| Accidental deletion protection | Prevents irreversible OU deletion in production-like environment |

## Security Principles Applied
- **Least Privilege** — Regular users cannot log into the Domain Controller
- **Separation of Duties** — Service accounts isolated from human accounts
- **Defense in Depth** — Accidental deletion protection on all OUs
- **Cloud Readiness** — UPN suffix aligned for Entra ID Connect synchronization

## Documentation
- [Phase 1 - Server Foundation](Documentation/Phase1-server-foundation.md)
- [Phase 2 - AD DS Installation](Documentation/Phase2-adds-installation.md)
- [Phase 3 - DC Promotion](Documentation/Phase3-dc-promotion.md)
- [Phase 4 - OU Structure](Documentation/Phase4-ou-structure.md)
- [Phase 5 - User Accounts](Documentation/Phase5-user-accounts.md)
- [Phase 6 - Verification](Documentation/Phase6-verification.md)
- [Phase 7 - Client VM](Documentation/Phase7-client-vm.md)
- [Design Decisions Log](Documentation/design-decisions.md)

## Skills Demonstrated
- Active Directory architecture and deployment
- Windows Server 2022 administration
- PowerShell for identity verification and automation
- Enterprise naming conventions and standards
- Identity lifecycle management principles
- Hybrid identity readiness (Entra ID Connect preparation)
- Technical documentation and portfolio development

## Future Enhancements
- [x] Phase 7 - Windows 10 client VM joined to domain
- [ ] Phase 8 - Entra ID Connect synchronization
- [ ] Phase 9 - Group Policy Object implementation
- [ ] Phase 10 - Privileged Identity Management integration