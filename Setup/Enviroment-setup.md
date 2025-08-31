# Azure IAM Lab Environment - Setup Guide

## Overview

This document provides a complete setup process for establishing a professional Azure Identity and Access Management (IAM) development environment on macOS. This environment enables hands-on practice with Azure Entra ID, PowerShell automation, and security policy implementation.

## Environment Specifications

- **Platform:** macOS
- **PowerShell Version:** 7.5.2
- **Primary Tools:** PowerShell, Visual Studio Code, GitHub
- **Azure Subscription:** Student subscription

## Prerequisites

- [ ] Azure account with appropriate permissions
- [ ] GitHub account for portfolio documentation
- [ ] macOS with admin privileges
- [ ] Internet connectivity for package downloads

## Phase 1: Install Development Tools

### Step 1: Install Homebrew Package Manager

Homebrew simplifies software installation on macOS and is widely used in enterprise environments.

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to PATH (replace 'username' with your actual username)
echo >> /Users/username/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/username/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Verify installation
brew --version
```

**Expected Output:** Homebrew version information

### Step 2: Install PowerShell 7

Using Microsoft's official PowerShell tap ensures you get the latest stable version with proper updates.

```bash
# Install PowerShell using Microsoft's official tap
brew install powershell/tap/powershell

# Verify installation
pwsh --version
```

**Expected Output:** PowerShell 7.5.x

**Reference:** [Official Microsoft PowerShell Installation Guide](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos)

### Step 3: Launch PowerShell

```bash
# Start PowerShell
pwsh
```

**Expected Prompt:** `PS /Users/username>`

## Phase 2: Install Azure PowerShell Modules

### Critical Note: Execution Policy on macOS

Unlike Windows, macOS PowerShell does not use execution policies. The `Set-ExecutionPolicy` command will return "Operation is not supported on this platform" - this is expected and normal behavior.

### Install Required Modules

#### 1. Azure PowerShell Module (Az)

```powershell
Install-Module -Name Az -Repository PSGallery -Force
```

- **Installation Time:** 5-10 minutes
- **Purpose:** Core Azure resource management and authentication

#### 2. Microsoft Graph PowerShell SDK

```powershell
Install-Module Microsoft.Graph -Repository PSGallery -Force
```

- **Installation Time:** 5-10 minutes
- **Purpose:** Modern Entra ID management, user/group operations, sign-in monitoring

#### 3. Azure AD Module (Legacy Support)

```powershell
Install-Module -Name AzureAD -Repository PSGallery -Force
```

- **Installation Time:** 2-3 minutes
- **Purpose:** Compatibility with existing enterprise scripts

### Verify Module Installation

```powershell
# Check Azure modules
Get-Module -ListAvailable Az*

# Check Microsoft Graph modules
Get-Module -ListAvailable Microsoft.Graph*

# Check AzureAD module
Get-Module -ListAvailable AzureAD*
```

**Expected Results:** Multiple modules listed for each category

## Phase 3: Test Azure Connectivity

### Connect to Azure

```powershell
# Authenticate to Azure (opens browser)
Connect-AzAccount

# Verify connection
Get-AzContext
```

**Expected Output:**
- Subscription information
- Tenant details
- Account information

### Connect to Microsoft Graph

```powershell
# Connect with necessary permissions for IAM work
Connect-MgGraph -Scopes "User.Read.All","Group.Read.All","Directory.Read.All","Application.Read.All"

# Test connection
Get-MgUser -Top 5
```

**Expected Output:** List of users from your tenant

### Verify Both Connections

```powershell
# Test Azure connection
Get-AzTenant

# Test Microsoft Graph connection
Get-MgUser -Top 5
```

## Phase 4: Visual Studio Code Setup

### Install VS Code

1. Download from [https://code.visualstudio.com/]
2. Install and launch application

### Essential Extensions

Install these extensions for Azure IAM development:

1. **PowerShell** (by Microsoft) - PowerShell language support
2. **Azure Account** (by Microsoft) - Azure authentication
3. **Azure Resources** (by Microsoft) - Resource management
4. **Markdown All in One** (by Yu Zhang) - Documentation editing
5. **GitHub Pull Requests and Issues** (by GitHub) - Repository management
6. **GitLens** (by GitKraken) - Git visualization and history

## Phase 5: GitHub Repository Setup

### Create Portfolio Repository

1. Navigate to [GitHub.com](https://github.com)
2. Create new repository:
  - **Name:** `azure-iam-portfolio`
  - **Visibility:** Public (for employer visibility)
  - **Include:** README.md, .gitignore (VisualStudio), MIT License

## Security Considerations for Documentation

### Safe to Include:
- Configuration steps and procedures
- PowerShell commands and scripts (sanitized)
- Architecture diagrams and workflows
- Learning outcomes and challenges
- Anonymized screenshots with redacted sensitive data

### Never Include:
- Actual tenant IDs or client secrets
- Real user email addresses or personal information
- API keys, certificates, or passwords
- Production domain names or subscription IDs
- Screenshots containing organizational data

### Example Data Sanitization:
- **Real Tenant ID**: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
- **Domain**: `domainname.onmicrosoft.com`

## Troubleshooting Common Issues

### Issue: "Install-Module not recognized"
- **Cause:** Typo in command
- **Solution:** Ensure correct spelling `Install-Module`

### Issue: "Operation is not supported on this platform"
- **Cause:** Trying to set execution policy on macOS
- **Solution:** Skip execution policy commands - not needed on macOS/Linux

### Issue: Module installation hangs
- **Cause:** Large download, network latency
- **Solution:** Wait patiently (5-10 minutes per module is normal)

### Issue: Azure authentication fails
- **Cause:** Browser blocking popups or network restrictions
- **Solution:** Allow popups, check firewall settings, try incognito mode
  
## Verification Checklist

- [x] PowerShell 7.5+ installed and functional
- [x] All Azure modules installed successfully
- [x] Azure connection established (`Get-AzContext` returns data)
- [x] Microsoft Graph connection established (`Get-MgUser` returns data)
- [x] VS Code installed with required extensions
- [x] GitHub repository created with proper structure
- [x] Environment documented with security considerations

## Additional Resources

- [Azure PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/azure/?view=azps-14.3.0)
- [Microsoft Graph PowerShell SDK](https://learn.microsoft.com/en-us/powershell/microsoftgraph/get-started?view=graph-powershell-1.0)
- [Microsoft Powershell Installation Guide](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos?view=powershell-7.5)
- [Homebrew Package Manager](https://brew.sh)
