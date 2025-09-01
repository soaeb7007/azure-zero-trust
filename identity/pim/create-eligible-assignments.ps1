param(
  [string]$TenantId,
  [string]$UserId,
  [string]$RoleDefinitionId = "62e90394-69f5-4237-9190-012177145e10" # Global Administrator
)
Import-Module Microsoft.Graph.Beta -ErrorAction Stop
Connect-MgGraph -TenantId $TenantId -Scopes "RoleManagement.ReadWrite.Directory","Directory.Read.All" -NoWelcome

$start = (Get-Date).ToUniversalTime().ToString("o")
$body = @{
  action = "adminAssign"
  justification = "ZT baseline - Eligible JIT"
  directoryScopeId = "/"
  principalId = $UserId
  roleDefinitionId = $RoleDefinitionId
  scheduleInfo = @{ startDateTime = $start; expiration = @{ type = "afterDuration"; duration = "P365D" } }
  ticketInfo = @{ ticketNumber = "JIT-INIT"; ticketSystem = "Change" }
}

New-MgBetaRoleManagementDirectoryRoleEligibilityScheduleRequest -BodyParameter $body | Out-Null
Write-Host "PIM eligibility request submitted."
