param([string]$TenantId,[string[]]$CriticalAppIds)
Connect-MgGraph -TenantId $TenantId -Scopes "Policy.ReadWrite.ConditionalAccess","Directory.Read.All"

$policy = @{
  DisplayName = "ZT - Critical apps: phishing-resistant + compliant device"
  State = "enabled"
  Conditions = @{
    Users = @{ IncludeUsers = @("All") }
    Applications = @{ IncludeApplications = $CriticalAppIds }
  }
  GrantControls = @{
    Operator = "AND"
    AuthenticationStrength = @{ DisplayName = "Phishing-resistant MFA" }
    BuiltInControls = @("compliantDevice")
  }
}

New-MgIdentityConditionalAccessPolicy -BodyParameter $policy | Out-Null
Write-Host "Created: Critical apps strong auth + compliant device"
