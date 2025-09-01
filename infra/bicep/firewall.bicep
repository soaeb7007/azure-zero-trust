param prefix string
param location string
param hubVnetId string

resource pip 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${prefix}-afw-pip'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

resource afw 'Microsoft.Network/azureFirewalls@2024-05-01' = {
  name: '${prefix}-afw'
  location: location
  sku: { name: 'AZFW_VNet', tier: 'Premium' }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: { id: '${hubVnetId}/subnets/AzureFirewallSubnet' }
          publicIPAddress: { id: pip.id }
        }
      }
    ]
    threatIntelMode: 'Alert'
  }
}
