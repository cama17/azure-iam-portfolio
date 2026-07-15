<#
    Phase 11 - Identity Governance and JML
    Graph PowerShell comparison for the entitlement management build.

    DISCLAIMER: This script is AI-assisted and was NOT executed against
    the tenant. All hands-on configuration for this phase was performed
    via the Entra admin center UI. This file exists as a side-by-side
    learning comparison, showing what each portal action maps to in
    code - it is not a record of commands actually run, and it has not
    been tested end to end. Reviewed and understood line by line before
    committing.
#>

Connect-MgGraph -Scopes "EntitlementManagement.ReadWrite.All", "Application.ReadWrite.All", "Directory.ReadWrite.All"

# --- Catalog: the container that holds governable resources ---
# Portal equivalent: Identity Governance > Catalogs > New catalog
$catalog = New-MgEntitlementManagementCatalog `
    -DisplayName "Stark-Engineering-Governance-Catalog" `
    -Description "Time-bound contractor access to the Engineering resource group"

# --- Add the resource group to the catalog ---
# Portal equivalent: Catalog > Resources > Add resources > SG-Engineering
$engineeringGroup = Get-MgGroup -Filter "displayName eq 'SG-Engineering'"

New-MgEntitlementManagementCatalogResource `
    -AccessPackageCatalogId $catalog.Id `
    -OriginId $engineeringGroup.Id `
    -OriginSystem "AadGroup"

# --- Access package: what a requestor is actually asking for ---
# Portal equivalent: Access packages > New access package > Basics tab
$accessPackage = New-MgEntitlementManagementAccessPackage `
    -DisplayName "Engineering Contractor Access" `
    -Description "Contractor access to Engineering resources" `
    -CatalogId $catalog.Id

# --- Assignment policy: requestor scope, approval, expiration, review ---
# Portal equivalent: Access package > Policies > Add policy (all tabs
# of this wizard are one continuous flow in the UI - requestor scope,
# approval settings, lifecycle/expiration, and access review settings
# all belong to the same policy object).
$contractorsGroup = Get-MgGroup -Filter "displayName eq 'SG-Contractors'"

New-MgEntitlementManagementAccessPackageAssignmentPolicy `
    -AccessPackageId $accessPackage.Id `
    -DisplayName "Contractor request policy" `
    -Description "Contractors access review policy" `
    -RequestorSettings @{
        ScopeType    = "SpecificDirectorySubjects"
        AcceptRequests = $true
        AllowedRequestors = @(
            @{ "@odata.type" = "#microsoft.graph.groupMembers"; GroupId = $contractorsGroup.Id }
        )
    } `
    -RequestApprovalSettings @{
        IsApprovalRequired = $true
        IsApprovalRequiredForExtension = $false
        IsRequestorJustificationRequired = $true
        ApprovalStages = @(
            @{
                ApprovalStageTimeOutInDays = 14
                IsApproverJustificationRequired = $true
                IsEscalationEnabled = $false
                PrimaryApprovers = @(
                    @{ "@odata.type" = "#microsoft.graph.singleUser"; UserId = "<CAM-object-id>" }
                )
            }
        )
    } `
    -ExpirationSettings @{
        Duration = "P1D"   # assignments expire after 1 day
    } `
    -ReviewSettings @{
        IsEnabled = $true
        RecurrenceType = "weekly"
        DurationInDays = 1
        ReviewerType = "Reviewers"
        Reviewers = @(
            @{ "@odata.type" = "#microsoft.graph.singleUser"; UserId = "<CAM-object-id>" }
        )
    }

# --- Test-gate app: App Registration + Enterprise Application ---
# Portal equivalent: App registrations > New registration, then
# Authentication > Add a platform > Web > redirect URI + ID tokens
$app = New-MgApplication `
    -DisplayName "Stark-Governance-Test-App" `
    -Web @{
        RedirectUris = @("https://jwt.ms")
        ImplicitGrantSettings = @{ EnableIdTokenIssuance = $true }
    }

# Portal equivalent: Enterprise applications > (this app is auto-created
# alongside the App Registration) > Properties > Assignment required = Yes
$servicePrincipal = New-MgServicePrincipal -AppId $app.AppId -AppRoleAssignmentRequired

# Portal equivalent: Enterprise applications > Users and groups > Add
# assignment > SG-Engineering
New-MgServicePrincipalAppRoleAssignedTo `
    -ServicePrincipalId $servicePrincipal.Id `
    -PrincipalId $engineeringGroup.Id `
    -ResourceId $servicePrincipal.Id `
    -AppRoleId "00000000-0000-0000-0000-000000000000"   # default access role

# --- Admin consent ---
# No clean single Graph PowerShell equivalent for this specific action -
# granting tenant-wide admin consent is normally a portal button even
# for engineers who script everything else. The closest programmatic
# path (patching an oauth2PermissionGrant with consentType=AllPrincipals)
# is unusual enough that it's flagged here rather than presented as routine.

# --- Diagnostic settings (AuditLogs + SigninLogs -> Log Analytics) ---
# This lives in the Azure Monitor surface, not Microsoft Graph, so the
# real equivalent is Azure PowerShell, not Graph PowerShell:
#
#   New-AzDiagnosticSetting -Name "governance-lab-logs" `
#       -ResourceId "/providers/Microsoft.aadiam" `
#       -WorkspaceId $logAnalyticsWorkspaceResourceId `
#       -Log @(
#           @{ Category = "AuditLogs"; Enabled = $true },
#           @{ Category = "SigninLogs"; Enabled = $true }
#       )
