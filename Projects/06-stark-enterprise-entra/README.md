# Project 06: Stark Enterprise Entra ID Lab

## Overview
This project extends the on-premises Active Directory environment
built in Project 03 into a full hybrid identity infrastructure
using Microsoft Entra ID. It covers identity management, access
control, security policies, and governance workflows aligned to
the Microsoft SC-300 Identity and Access Administrator exam
objectives.

The environment simulates a real enterprise scenario where
on-premises AD users are synced to the cloud via Entra Connect,
and new cloud-only users are provisioned directly in Entra ID.
Every phase produces hands-on evidence documented in this
repository.

## Builds On
Project 03 - Stark Enterprise AD Lab established:
- On-premises Windows Server 2022 Domain Controller
- 15 users synced to Entra ID via Entra Connect
- starkenterpriselab.com verified as the primary domain

## Identity Population

### Hybrid Users (synced from on-premises AD)
| Name | Department | Role |
|---|---|---|
| Tony Stark | Engineering | CTO |
| Bruce Banner | Engineering | Developer |
| Shuri | Engineering | Developer |
| Nick Fury | Security | Security Manager |
| Natasha Romanoff | Security | Security Analyst |
| Maria Hill | HR | HR Manager |
| Phil Coulson | IT | IT Manager |
| Peter Parker | IT | Helpdesk Technician |
| Jennifer Walters | Legal | - |
| Matt Murdock | Legal | - |
| Happy Hogan | Operations | - |
| Pepper Potts | Operations | - |

### Cloud-Only Users (created in this project)
| Name | Department | Role |
|---|---|---|
| Steve Rogers | Operations | Operations Manager |
| Sam Wilson | Operations | Operations Staff |
| Bucky Barnes | Operations | Operations Staff |
| Sharon Carter | HR | HR Generalist |
| Logan | Contractor | Contractor Developer (B2B Guest) |
| JARVIS | Vendor | Vendor Support (B2B Guest) |

## Security Groups
| Group | Members |
|---|---|
| SG-Security | Nick Fury, Natasha Romanoff |
| SG-IT | Phil Coulson, Peter Parker |
| SG-HR | Maria Hill, Sharon Carter |
| SG-Engineering | Tony Stark, Bruce Banner, Shuri |
| SG-Operations | Steve Rogers, Sam Wilson, Bucky Barnes, Happy Hogan, Pepper Potts |
| SG-Contractors | Logan, JARVIS |
| SG-All-Employees | All users except contractors |
| SG-Privileged-Eligible | Admin account only |

## Core Technologies
- Microsoft Entra ID (Premium P2)
- Microsoft Entra Connect (Hybrid Sync)
- Windows Server Active Directory
- PowerShell 7
- Microsoft Graph PowerShell SDK
- Microsoft Graph REST API

## SC-300 Exam Alignment
Each phase maps directly to SC-300 lab objectives across
all four exam modules:
- Module 01: Implement an Identity Management Solution
- Module 02: Implement Authentication and Access Management
- Module 03: Implement Access Management for Apps
- Module 04: Plan and Implement an Identity Governance Strategy

## Project Phases
| Phase | Title | SC-300 Labs | Status |
|---|---|---|---|
| 01 | Hybrid Identity Review | Lab 07 | Complete |
| 02 | Cloud Users and B2B Collaboration | Labs 04, 05 | Complete |
| 03 | Groups and Licensing | Labs 01, 03 | In Progress |
| 04 | Tenant Properties | Lab 02 | Planned |
| 05 | Federated Identity Provider | Lab 06 | Planned |
| 06 | PowerShell and Graph API | Lab 01 | Planned |
| 07 | Security Baseline - MFA and SSPR | Labs 08, 09, 15 | Planned |
| 08 | Conditional Access | Labs 13, 14 | Planned |
| 09 | Privileged Identity Management | Labs 11, 26 | Planned |
| 10 | Identity Governance | Labs 22, 23, 24, 25 | Planned |
| 11 | Enterprise Applications | Labs 19, 20, 21 | Planned |
| 12 | Azure VM and Key Vault | Labs 10, 16 | Planned |
| 13 | Defender for Cloud Apps | Labs 17, 18 | Planned |
| 14 | Microsoft Sentinel and KQL | Lab 27 | Planned |
| 15 | Secure Score and Finalization | Lab 28 | Planned |

## Repository Structure
- `/Documentation`: Markdown runbooks for each phase
- `/Screenshots`: Visual evidence of configurations and outcomes
- `/Scripts`: PowerShell and Graph API automation scripts

## Scripting Disclaimer
Any PowerShell script or Graph API call used in this project
that was not written entirely from scratch includes the
following note in the documentation:

Script written with AI assistance.
Reviewed and understood line by line before use.
This reflects standard enterprise practice where engineers
validate and adapt scripts before deployment.

## Billing Approach
Phases involving Azure resources (VMs, Key Vault, Sentinel)
use minimum tier configurations. Resources are deleted
immediately after each lab task is completed to avoid
unnecessary charges. Deletion is confirmed before moving on.