# Design Decisions Log

## Overview
This document captures every significant design decision made
during the Stark Enterprise Active Directory Lab project. Each
decision includes the context, the options considered, the
choice made, and the rationale behind it. This mirrors the
documentation standard expected of enterprise IAM engineers.

---

## Decision 1 - Operating System Edition

**Context:**
Windows Server 2022 offers two installation options — Desktop
Experience (GUI) and Server Core (command line only).

**Options Considered:**
| Option | Pros | Cons |
|---|---|---|
| Desktop Experience | Easy navigation, visual learning, screenshot capability | Larger attack surface, more resources |
| Server Core | Smaller attack surface, less resource usage, production standard | Steep learning curve, no GUI |

**Decision:** Desktop Experience

**Rationale:**
Lab environment prioritizes learning and documentation over
production hardening. Desktop Experience enables visual
navigation and portfolio screenshots. In production, Server
Core would be the correct choice due to its smaller attack
surface and reduced vulnerability exposure.

---

## Decision 2 - Server Naming Convention

**Context:**
Windows assigns a random default name to new servers.
Enterprise environments require consistent naming standards.

**Options Considered:**
| Option | Example |
|---|---|
| Random default | WIN-ABC123XYZ |
| Role based naming | STARK-DC01 |

**Decision:** STARK-DC01

**Rationale:**
Enterprise naming conventions allow any engineer to instantly
identify a server's company, role, and instance number without
documentation lookup. At scale with hundreds of servers,
consistent naming is essential for operational efficiency
and incident response speed.

---

## Decision 3 - Static IP Address Assignment

**Context:**
Servers can receive IP addresses dynamically (DHCP) or have
them manually assigned (static).

**Options Considered:**
| Option | Behavior |
|---|---|
| Dynamic (DHCP) | IP can change on each reboot |
| Static | IP is permanently fixed |

**Decision:** Static IP — 192.168.1.10

**Rationale:**
DNS records point to the Domain Controller's IP address.
If the IP changes, DNS records become stale and authentication
fails across the entire domain. A static IP guarantees DNS
records remain accurate permanently. This is a non-negotiable
requirement for any Domain Controller.

---

## Decision 4 - DNS Configuration

**Context:**
The Domain Controller needs a DNS server to resolve domain
queries. Options include pointing to an external DNS provider
or running DNS locally.

**Options Considered:**
| Option | DNS Server |
|---|---|
| External DNS | 8.8.8.8 (Google) |
| Self-hosted DNS | 127.0.0.1 (loopback) |

**Decision:** 127.0.0.1 (loopback — self-hosted)

**Rationale:**
The Domain Controller runs its own DNS server. Pointing to
the loopback address means the DC resolves DNS queries itself.
External DNS providers like Google have no knowledge of
internal resources like starkenterpriselab.com — pointing
to them would cause all internal DNS lookups to fail.

---

## Decision 5 - Forest Functional Level

**Context:**
Forest and Domain Functional Levels determine which AD
features are available and which legacy systems are supported.

**Options Considered:**
| Level | Features | Compatibility |
|---|---|---|
| Windows Server 2012 R2 | Limited modern features | Maximum legacy support |
| Windows Server 2016 | All modern features | Good compatibility |
| Windows Server 2022 | Latest features | Minimum compatibility |

**Decision:** Windows Server 2016

**Rationale:**
Windows Server 2016 functional level provides all modern
Active Directory features while maintaining the best
compatibility for potential future domain controller additions.
In a real enterprise this would be set to match the oldest
Domain Controller in the environment.

---

## Decision 6 - Domain Name Selection

**Context:**
The AD forest root domain name must be chosen carefully
as it cannot be easily changed after creation.

**Options Considered:**
| Option | Example | Cloud Sync |
|---|---|---|
| Internal only domain | stark.local | Requires UPN remediation |
| Registered public domain | starkenterpriselab.com | Clean sync |

**Decision:** starkenterpriselab.com

**Rationale:**
Using the same domain name as the verified Entra ID custom
domain ensures clean hybrid identity synchronization via
Entra Connect. If an internal domain like stark.local was
used instead, every user UPN would require remediation before
cloud sync could work. This decision future-proofs the
environment for hybrid identity integration.

---

## Decision 7 - OU Structure Design

**Context:**
Users and computers must be organized inside Active Directory.
The default Users container exists but has significant limitations.

**Options Considered:**
| Option | GPO Support | Scalability |
|---|---|---|
| Default Users container | No | Poor |
| Flat OU structure | Yes | Limited |
| Department based OUs | Yes | Excellent |

**Decision:** Department based OU structure with 6 OUs

**Rationale:**
Group Policy Objects can only be applied to OUs — not to
default containers. Department based OUs enable granular
policy application per business unit. This mirrors real
enterprise AD design where security controls are applied
at the organizational boundary level.

---

## Decision 8 - ServiceAccounts OU Isolation

**Context:**
Service accounts could be placed in department OUs or
isolated in a dedicated OU.

**Options Considered:**
| Option | Security | Auditability |
|---|---|---|
| Mixed with user accounts | Poor | Difficult |
| Dedicated ServiceAccounts OU | Strong | Excellent |

**Decision:** Dedicated ServiceAccounts OU

**Rationale:**
Service accounts are non-interactive accounts used by
systems and automated scripts. They require stricter
policies, separate password rotation schedules, and
isolated monitoring for security auditing. Mixing them
with human accounts creates audit complexity and increases
the risk of accidental modification.

---

## Decision 9 - Accidental Deletion Protection

**Context:**
Active Directory allows OUs to be deleted along with all
their contents. This action is difficult to reverse without
a backup.

**Decision:** Enable protection on all OUs at creation

**Rationale:**
In a real enterprise, accidentally deleting an OU containing
hundreds of users would be catastrophic and potentially
irreversible without a full backup restore. Protection forces
a deliberate two-step process before deletion is allowed,
preventing career-ending mistakes in production environments.

---

## Decision 10 - User Naming Convention

**Context:**
Enterprise user accounts require a consistent naming standard
for UPNs and display names.

**Options Considered:**
| Format | Example |
|---|---|
| First initial last name | tstark@starkenterpriselab.com |
| Firstname.lastname | tony.stark@starkenterpriselab.com |
| Employee ID | emp001@starkenterpriselab.com |

**Decision:** firstname.lastname@starkenterpriselab.com

**Rationale:**
The firstname.lastname format is the most common enterprise
standard. It is human readable, self-documenting, and
consistent with Microsoft's recommended UPN format for
Entra ID synchronization. It also aligns with email address
conventions making it intuitive for end users.

---

## Summary

Every decision in this project was made deliberately with
three criteria in mind:

1. **Security** - Does this choice reduce attack surface
   and follow least privilege principles?

2. **Scalability** - Does this choice work at enterprise
   scale with hundreds or thousands of users?

3. **Cloud Readiness** - Does this choice prepare the
   environment for hybrid identity integration with
   Microsoft Entra ID?

These are the same criteria enterprise IAM engineers apply
when designing identity infrastructure in production environments.