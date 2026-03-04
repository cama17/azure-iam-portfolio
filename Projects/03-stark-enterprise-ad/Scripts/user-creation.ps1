# ============================================================
# Stark Enterprise Active Directory - User Creation Script
# Author: Craig McGuinness
# Description: Automates creation of all 15 Stark Enterprise
#              user accounts across 6 Organizational Units
# NOTE: Users were created manually in the lab environment to ensure proper OU placement.
# This Script serves as a reference to demostrate the automaded equalent of the manual process and
# would be used for bulk provisioning in a production environment.
# ============================================================

# Domain Variables
$domain = "starkenterpriselab.com"
$domainDN = "DC=starkenterpriselab,DC=com"
$userPassword = ConvertTo-SecureString "Liverpool1!" -AsPlainText -Force
$svcPassword = ConvertTo-SecureString "Samlizzy7!" -AsPlainText -Force

# ============================================================
# User Definitions
# ============================================================

$users = @(
    # Executives
    @{FirstName="Tony"; LastName="Stark"; OU="Executives"; Type="User"},
    @{FirstName="Pepper"; LastName="Potts"; OU="Executives"; Type="User"},

    # Engineering
    @{FirstName="Bruce"; LastName="Banner"; OU="Engineering"; Type="User"},
    @{FirstName="Peter"; LastName="Parker"; OU="Engineering"; Type="User"},
    @{FirstName="Shuri"; LastName=""; OU="Engineering"; Type="User"},

    # Security
    @{FirstName="Nick"; LastName="Fury"; OU="Security"; Type="User"},
    @{FirstName="Maria"; LastName="Hill"; OU="Security"; Type="User"},
    @{FirstName="Natasha"; LastName="Romanoff"; OU="Security"; Type="User"},

    # Legal
    @{FirstName="Jennifer"; LastName="Walters"; OU="Legal"; Type="User"},
    @{FirstName="Matt"; LastName="Murdock"; OU="Legal"; Type="User"},

    # Operations
    @{FirstName="Happy"; LastName="Hogan"; OU="Operations"; Type="User"},
    @{FirstName="Phil"; LastName="Coulson"; OU="Operations"; Type="User"},

    # Service Accounts
    @{FirstName="svc-entra"; LastName=""; OU="ServiceAccounts"; Type="Service"},
    @{FirstName="svc-backup"; LastName=""; OU="ServiceAccounts"; Type="Service"},
    @{FirstName="svc-monitoring"; LastName=""; OU="ServiceAccounts"; Type="Service"}
)

# ============================================================
# User Creation Loop
# ============================================================

foreach ($user in $users) {

    # Build username and UPN
    if ($user.LastName -ne "") {
        $username = "$($user.FirstName.ToLower()).$($user.LastName.ToLower())"
        $displayName = "$($user.FirstName) $($user.LastName)"
    } else {
        $username = $user.FirstName.ToLower()
        $displayName = $user.FirstName
    }

    $upn = "$username@$domain"
    $ouPath = "OU=$($user.OU),$domainDN"

    # Set password based on account type
    if ($user.Type -eq "Service") {
        $password = $svcPassword
    } else {
        $password = $userPassword
    }

    # Create the user account
    try {
        New-ADUser `
            -Name $displayName `
            -GivenName $user.FirstName `
            -Surname $user.LastName `
            -SamAccountName $username `
            -UserPrincipalName $upn `
            -Path $ouPath `
            -AccountPassword $password `
            -Enabled $true `
            -PasswordNeverExpires $true `
            -ChangePasswordAtLogon $false

        Write-Host "Created: $upn" -ForegroundColor Green

    } catch {
        Write-Host "Failed: $upn - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "User creation complete." -ForegroundColor Cyan

# ============================================================
# Verification
# ============================================================

Write-Host ""
Write-Host "Verifying created accounts..." -ForegroundColor Cyan
Get-ADUser -Filter * | Select-Object Name, UserPrincipalName, Enabled | Format-Table -AutoSize