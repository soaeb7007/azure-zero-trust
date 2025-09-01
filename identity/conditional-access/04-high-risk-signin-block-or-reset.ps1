param([string]$TenantId,[switch]$Block)
Connect-MgGraph -TenantId $TenantId -Scopes "Policy.ReadWrite.ConditionalAccess","Directory.Read.All"

$grant = if ($Block) @{ Operator="OR"; BuiltInControls=@("block") } else @{ Operator="OR"; BuiltInControls=@("passwordChange") }

$policy = @{
  DisplayName = "ZT - High-risk sign-ins response"
  State = "enabled"
  Conditions = @{ Users = @{ IncludeUsers = @("All") }; SignInRiskLevels = @("high") }
  GrantControls = $grant
}

New-MgIdentityConditionalAccessPolicy -BodyParameter $policy | Out-Null
Write-Host "Created: High-risk sign-ins policy"
