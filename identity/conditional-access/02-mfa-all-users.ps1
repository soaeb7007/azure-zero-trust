param([string]$TenantId,[string[]]$ExcludeUsers)
Connect-MgGraph -TenantId $TenantId -Scopes "Policy.ReadWrite.ConditionalAccess","Directory.Read.All"

$policy = @{
  DisplayName = "ZT - Require MFA for all users"
  State = "enabled"
  Conditions = @{
    Users = @{ IncludeUsers = @("All"); ExcludeUsers = $ExcludeUsers }
    Applications = @{ IncludeApplications = @("All") }
  }
  GrantControls = @{ Operator = "AND"; BuiltInControls = @("mfa") }
  SessionControls = @{ SignInFrequency = @{ IsEnabled = $true; Value = 12; Type = "hours" } }
}

New-MgIdentityConditionalAccessPolicy -BodyParameter $policy | Out-Null
Write-Host "Created: MFA for all users"
