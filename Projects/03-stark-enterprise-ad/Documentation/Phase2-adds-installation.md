# Phase 2 — AD DS Role Installation

## Objective
Install the Active Directory Domain Services role onto STARK-DC01,
preparing it for Domain Controller promotion.

## Steps Completed

### 1. Add Roles and Features Wizard
- Opened Server Manager
- Selected Add Roles and Features
- Selected Role-based installation
- Selected STARK-DC01 as target server

### 2. Role Selection
- Selected Active Directory Domain Services
- Accepted all required dependency features

### 3. Dependency Features Auto-Installed
- Group Policy Management
- Remote Server Administration Tools
- .NET Framework 4.8
- Windows PowerShell modules

### 4. Installation Result
- AD DS role successfully installed on STARK-DC01
- Promote link appeared in Server Manager yellow flag

## Design Decisions

**Why install DNS at the same time as AD DS?**
Active Directory is completely dependent on DNS. Without DNS,
computers cannot locate the Domain Controller and authentication
fails entirely. Installing them together ensures they are
configured to work with each other from the start.

**Why are Installing and Promoting two separate steps?**
Installing AD DS gives the server the capability to become a 
Domain Controller, like hiring someone for a job. 
Promotion is the configuration step that actually activates it like
giving them their access and credentials on day one.

**What are dependency features?**
Software that AD DS requires to function properly. Windows
automatically identifies and installs these, they do not
need to be selected manually.

## Verification
- AD DS role confirmed in Server Manager
- Yellow warning flag appeared confirming installation
- Promote link visible and ready for Phase 3

## Screenshots
- 01-ADDS-info-page.png
- 02-ADDS-installing.png
- 03-ADDS-success.png
- 04-promote-link.png