# Phase 6 — Verification & Testing

## Objective
Systematically verify the Active Directory environment is fully
operational using PowerShell commands to confirm user provisioning,
OU placement, account health, and DNS resolution.

## Verification Approach
Domain Controllers do not allow regular users to log in locally
by default. This is the Least Privilege security principle because
users only get access to what they absolutely need. Instead of
direct login testing, systematic PowerShell verification was
used to prove each component is working correctly.

## Tests Performed

### Test 1 — All Users Verified
**Command:**
```powershell
Get-ADUser -Filter * | Select-Object Name, UserPrincipalName, Enabled | Format-Table -AutoSize
```
**Result:** All 15 user accounts confirmed in AD with correct
UPNs and Enabled status True

### Test 2 — OU Placement Verified
**Command:**
```powershell
Get-ADUser -Filter * -Properties DistinguishedName | Select-Object Name, DistinguishedName | Format-Table -AutoSize
```
**Result:** All 15 users confirmed in correct OUs via
DistinguishedName attribute

**Distinguished Name Format:**
```
CN=Tony Stark,OU=Executives,DC=starkenterpriselab,DC=com
```
| Component | Meaning |
|---|---|
| CN | Common Name — the user object |
| OU | Organizational Unit — the folder |
| DC | Domain Component — part of domain name |

### Test 3 — Account Health Verified
**Command:**
```powershell
Get-ADUser -Identity "tony.stark" -Properties * | Select-Object Name, UserPrincipalName, Enabled, LockedOut, BadLogonCount | Format-Table -AutoSize
```
**Result:**
| Property | Value |
|---|---|
| Enabled | True |
| LockedOut | False |
| BadLogonCount | 0 |

### Test 4 — All Account Health Verified
**Command:**
```powershell
Get-ADUser -Filter * -Properties Enabled, LockedOut | Select-Object Name, Enabled, LockedOut | Format-Table -AutoSize
```
**Result:** All 15 accounts confirmed Enabled True and
LockedOut False

### Test 5 — DNS Resolution Verified
**Command:**
```powershell
Resolve-DnsName starkenterpriselab.com
```
**Result:** starkenterpriselab.com resolved to 192.168.1.10
confirming DNS is functioning correctly

## Security Principles Demonstrated

**Least Privilege**
Regular users cannot log into the Domain Controller directly.
Only Domain Admins have local login rights to the DC. This
limits the attack surface of the most sensitive server in
the environment.

**Systematic Verification**
Rather than assuming the environment works, each component
was verified independently:
- User existence
- OU placement
- Account health
- DNS resolution

## Why This Matters
In a real enterprise, engineers validate environments
systematically rather than assuming configurations are
correct. This approach mirrors production verification
workflows and demonstrates technical maturity beyond
simply following setup wizards.

## Future Testing Enhancement
A Windows 10/11 client VM joined to the domain would enable:
- Direct domain user login testing
- Group Policy application verification
- Full end to end authentication flow demonstration
This is planned as Phase 8 of the portfolio project.

## Screenshots
- 01-verify-all-users.png
- 02-verify-ou-placement.png
- 03-verify-tony-stark.png
- 04-verify-all-accounts-health.png
- 05-dns-verification.png