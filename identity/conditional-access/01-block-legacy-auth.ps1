param([string]$TenantId)
Import-Module Microsoft.Graph.Authentication -ErrorAction Stop
Import-Module Microsoft.Graph.Identity.SignIns -ErrorAction Stop
Connect-MgGraph -TenantId $TenantId -Scopes "Policy.ReadWrite.ConditionalAccess","Directory.Read.All"

$policy = @{
  DisplayName = "ZT - Block Legacy Authentication"
  State = "enabled"
  Conditions = @{
    Users = @{ IncludeUsers = @("All") }
    ClientAppTypes = @("exchangeActiveSync","other")
  }
  GrantControls = @{ Operator = "OR"; BuiltInControls = @("block") }
}

New-MgIdentityConditionalAccessPolicy -BodyParameter $policy | Out-Null
Write-Host "Created: Block Legacy Authentication"
