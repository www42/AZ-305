# This script deploys the template "main.bicep".
# ----------------------------------------------

# PowerShell module "Az" required
Get-Module -Name Az -ListAvailable

# Login to Azure
Login-AzAccount
$MySignInName = (Get-AzContext).Account.Id

# Be sure you are authorized to read and write to the Root Management Group. Lets do a simple test
Get-AzManagementGroup | Where-Object DisplayName -EQ "Root Management Group"

# ---------------------------------------
# If "forbidden" elevate yourself ...
$Method = 'POST'
$Uri = 'https://management.azure.com/providers/Microsoft.Authorization/elevateAccess?api-version=2015-07-01'
$Token = Get-AzAccessToken | % Token
$Headers = @{"authorization" = "Bearer $Token"}
$Body = ''
$Params = @{
    Method  = $Method
    Uri     = $Uri
    Headers = $Headers
    Body    = $Body
    ContentType = "application/json"
}
Invoke-RestMethod @Params

# ... and assign Owner role to the Root Management Group
$RootGroup = Get-AzManagementGroup | Where-Object DisplayName -EQ "Root Management Group"
New-AzRoleAssignment -SignInName $MySignInName -RoleDefinitionName "Owner" -Scope $RootGroup.Id
# EndIf
# ---------------------------------------


# Get the Root Mangenment Group. It's Name is needed to scope the deployment (line 45). 
$RootGroup = Get-AzManagementGroup | Where-Object DisplayName -EQ "Root Management Group"

# The display name of the new management group 
$MgDisplayName = "Tailwind Traders"

# We are ready to go. Deploy the bicep template
New-AzManagementGroupDeployment `
    -ManagementGroupId $RootGroup.Name `
    -Location westeurope `
    -TemplateFile main.bicep `
    -TemplateParameterObject @{mgDisplayName=$MgDisplayName}

# List management groups
Get-AzManagementGroup | Format-Table DisplayName,Name

# Good luck!