# Microsoft Defender - Attack Surface Reduction baseline
$rules = @{
  "0564e57a-75ec-4d0d-b1e1-3772240f72e5" = 1
  "3b576869-a4ec-4529-8536-b80a7769e899" = 1
  "5beb7efe-fd9a-4556-801d-275e5ffc04cc" = 1
  "d4f940ab-401b-4efc-aadc-ad5f3c50688a" = 1
  "26190899-1602-49e8-8b27-eb1d0a1ce869" = 1
  "be9ba2d9-53ea-4cdc-84e5-9b1eeee46550" = 1
  "d3e037e1-3eb8-44c8-a917-57927947596d" = 1
  "01443614-cd74-433a-b99e-2ecdc07bfc25" = 1
}
$rules.GetEnumerator() | ForEach-Object {
  Add-MpPreference -AttackSurfaceReductionRules_Ids $_.Key -AttackSurfaceReductionRules_Actions $_.Value
}
Set-MpPreference -EnableNetworkProtection Enabled
# Consider enabling Controlled Folder Access after pilot
Write-Host "Applied MDE ASR baseline and enabled Network Protection."
