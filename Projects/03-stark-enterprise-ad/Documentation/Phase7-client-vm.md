# Phase 7 - Windows 11 Client VM

## Objective
Complete the Active Directory lab by adding a Windows 11 workstation
to the domain and testing full end-to-end user authentication.

## Environment Details
| Setting | Value |
|---|---|
| VM Name | STARK-WRK01 |
| Operating System | Windows 11 Pro |
| Network | Internal Network - StarkLab |
| Static IP | 192.168.1.20 |
| Subnet Mask | 255.255.255.0 |
| DNS Server | 192.168.1.10 (STARK-DC01) |
| Domain Joined | starkenterpriselab.com |

## Steps Completed

### 1. Switched STARK-DC01 to Internal Network
- Changed network adapter from NAT to Internal Network in VirtualBox
- Named the network StarkLab
- Internal Network allows direct VM-to-VM communication
- NAT does not allow two VMs to talk directly to each other

### 2. Created STARK-WRK01 VM
- Created new VM in VirtualBox
- Set network to Internal Network - StarkLab before booting
- Attached Windows 11 Pro ISO

### 3. Installed Windows 11
- Bypassed forced internet connection during setup
- Created local account StarkUser to complete installation
- Renamed computer to STARK-WRK01 after installation

### 4. Assigned Static IP and DNS
- Assigned static IP 192.168.1.20
- Set DNS server to 192.168.1.10 (STARK-DC01)
- DNS must point to DC so workstation can locate the domain

### 5. Verified Network Connectivity
- Ran ping 192.168.1.10 from STARK-WRK01
- First ping failed - workstation had no IP assigned yet
- After assigning static IP ping succeeded
- Confirmed two VMs can communicate before joining domain

### 6. Joined Domain
- Joined STARK-WRK01 to starkenterpriselab.com via System Properties
- Provided Administrator credentials to authorize the join
- Machine restarted automatically after joining
- STARK-WRK01 appeared in Computers container in ADUC on STARK-DC01

### 7. Authenticated as Tony Stark
- Logged in as tony.stark@starkenterpriselab.com from STARK-WRK01
- Authentication succeeded -> full end-to-end flow confirmed
- Ran whoami -> returned starkenterprise\tony.stark
- Ran nltest /dsgetdc:starkenterpriselab.com -> confirmed STARK-DC01
  handled the authentication request

## Commands Used

**ping 192.168.1.10**
Sends a test packet to the DC and waits for a reply. Used to confirm
network connectivity between the two VMs before attempting domain join.

**ipconfig /all**
Shows full network configuration including DNS server settings.
Used to confirm DNS was correctly pointing to 192.168.1.10.

**whoami**
Returns the currently logged in user. After Tony Stark logged in,
whoami returned starkenterprise\tony.stark confirming the login
was a genuine domain authentication.

**nltest /dsgetdc:starkenterpriselab.com**
nltest stands for network logon test. The /dsgetdc flag means get
domain controller. This command asks Windows which Domain Controller
is currently handling authentication for a specific domain. We ran
this to confirm STARK-DC01 was the DC that authenticated Tony Stark's
login - proving the full authentication chain worked correctly from
workstation to Domain Controller.

## Authentication Flow - What Happened Behind the Scenes
When Tony Stark logged in, this is the sequence that occurred:

1. STARK-WRK01 asked DNS (192.168.1.10) where STARK-DC01 is located
2. DNS returned 192.168.1.10 - the DC answered its own DNS query
3. STARK-WRK01 sent Tony Stark's credentials to STARK-DC01
4. STARK-DC01 verified the credentials against the AD database
5. STARK-DC01 issued an authentication token confirming identity
6. STARK-WRK01 accepted the token and loaded Tony Stark's desktop

## Design Decisions

**Why Internal Network instead of NAT?**
NAT does not allow direct VM-to-VM communication. Internal Network
creates a private network between VMs only. Both VMs used the same
network name StarkLab to ensure they were on the same segment.

**Why a static IP on the workstation?**
In our lab there is no DHCP server to assign IPs automatically.
Without a static IP the workstation had no IP address, which is
why the first ping failed. Static IP 192.168.1.20 placed the
workstation on the same subnet as the DC at 192.168.1.10.

**Why does DNS have to point to the DC?**
Active Directory depends entirely on DNS. When a computer tries
to find the domain, the first step is always a DNS lookup. If
DNS points to an external server, it has no knowledge of
starkenterpriselab.com and the lookup fails.

## Verification Results
- Windows 11 VM created and configured as STARK-WRK01
- Static IP confirmed via ipconfig /all
- Ping to 192.168.1.10 succeeded
- STARK-WRK01 joined to starkenterpriselab.com
- STARK-WRK01 visible in AD Computers container
- Tony Stark authenticated successfully from workstation
- whoami confirmed starkenterprise\tony.stark
- nltest confirmed STARK-DC01 handled authentication

## Screenshots
- 01-wrk01-first-login.png
- 02-tony-stark-login.png
- 03-whoami-tony-stark.png
- 04-dc-verification.png
- 05-wrk01-in-ad.png