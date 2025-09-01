param prefix string
param location string
param hubVnetId string

resource pip 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${prefix}-bas-pip'
  location: location
  sku: { name: 'Standard' }
  properties: { publicIPAllocationMethod: 'Static' }
}

resource bastion 'Microsoft.Network/bastionHosts@2024-05-01' = {
  name: '${prefix}-bastion'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: { id: '${hubVnetId}/subnets/AzureBastionSubnet' }
          publicIPAddress: { id: pip.id }
        }
      }
    ]
    sku: { name: 'Standard' }
  }
}
