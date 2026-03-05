# Phase 1 - Server Foundation

## Objective
Build the base Windows Server 2022 environment that will become 
the Stark Enterprises Domain Controller.

## Environment Details
| Setting | Value |
|---|---|
| Hostname | STARK-DC01 |
| OS | Windows Server 2022 Standard (Desktop Experience) |
| IP Address | 192.168.1.10 |
| Subnet Mask | 255.255.255.0 |
| Default Gateway | 192.168.1.1 |
| DNS Server | 127.0.0.1 (loopback) |

## Steps Completed

### 1. Windows Server 2022 Installation
- Booted VM from ISO
- Selected Standard (Desktop Experience) edition
- Completed installation with custom disk configuration

### 2. Server Rename
- Renamed from default name to STARK-DC01
- Following enterprise naming convention:
  - STARK = company identifier
  - DC = role (Domain Controller)
  - 01 = first instance

### 3. Static IP Configuration
- Assigned static IP 192.168.1.10
- Set DNS to 127.0.0.1 (loopback)
- Verified via ipconfig command

## Design Decisions

**Why Desktop Experience?**
Chosen for lab environment to enable GUI navigation and portfolio 
screenshots. In production, Server Core is preferred due to smaller 
attack surface and reduced vulnerabilities.

**Why Static IP?**
Domain Controllers must have static IPs because DNS records point 
to the DC's IP address. A dynamic IP would cause DNS records to 
become stale, breaking authentication across the entire domain.

**Why DNS set to 127.0.0.1?**
The DC runs its own DNS server. Pointing DNS to the loopback address 
means the DC resolves DNS queries itself rather than asking an 
external server about internal resources.

## Verification
- ipconfig confirmed IP address 192.168.1.10
- Server name confirmed as STARK-DC01 in Server Manager

## Screenshots
- 01-first-login.png
- 02-server-rename.png
- 03-static-ip.png
- 04-ipconfig-verification.png