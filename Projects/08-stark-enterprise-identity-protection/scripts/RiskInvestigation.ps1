<#
    Project 08 - Risk-Based Conditional Access + Identity Protection
    Microsoft Graph PowerShell: investigation and remediation of a
    real risky user.

    DISCLAIMER: Unlike prior side-by-side comparison scripts in this
    portfolio, every command below was actually run against the
    starkenterpriselab.com tenant during this lab. Real output is
    captured in scenarios.md. Written with AI assistance, reviewed and
    understood line by line before running, consistent with standard
    engineering practice of validating any script before it touches a
    real environment.
#>

# Install the two SDK modules this lab actually needs, not the full
# Microsoft.Graph meta-module, which would pull in far more scopes
# than this investigation requires.
Install-Module Microsoft.Graph.Authentication -Scope CurrentUser
Install-Module Microsoft.Graph.Identity.SignIns -Scope CurrentUser

# Connect with least-privilege delegated scopes:
# - IdentityRiskyUser.ReadWrite.All lets this session read and act on
#   risky user records (dismiss, confirm compromised).
# - IdentityRiskEvent.Read.All lets this session read the underlying
#   risk detections that feed those records.
Connect-MgGraph -Scopes "IdentityRiskyUser.ReadWrite.All", "IdentityRiskEvent.Read.All"

# Confirm the connection actually holds the scopes requested, not
# whatever scopes a prior cached session happened to have.
Get-MgContext

# List real risk detections raised by Identity Protection. This is
# the individual signal (for example, anonymizedIPAddress from a Tor
# exit node), not yet aggregated to a user-level risk state.
Get-MgRiskDetection | Format-List

# Pull the aggregated risky-user record for the test account. This is
# where RiskState (atRisk, dismissed, remediated) actually lives.
Get-MgRiskyUser -Filter "userPrincipalName eq 'loki@starkenterpriselab.com'" | Format-List

# Attempt to clear the risk flag. -PassThru returns True/False instead
# of nothing, so a silent failure doesn't look identical to a silent
# success.
#
# Real result in this lab: this returned True and set RiskState to
# dismissed, but it did NOT restore the account's access. A fresh
# risky sign-in re-triggered the identical block, because dismiss
# never touched the actual cause: an account with zero MFA methods
# registered, unable to prove itself while flagged risky. See
# scenarios.md for the full trace and the fix that actually worked
# (an admin-generated temporary password, applied through the portal,
# not through this SDK).
Invoke-MgDismissRiskyUser -UserIds "2277039d-a7e1-4aaf-b6ef-b0a587f6544a" -PassThru

# Re-check the risk state after the real fix (temporary password
# reset) was applied through the Users blade.
Get-MgRiskyUser -Filter "userPrincipalName eq 'loki@starkenterpriselab.com'" | Format-List
# Real result: RiskState Remediated, RiskDetail userPerformedSecuredPasswordReset
