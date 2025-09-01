param prefix string
param location string

resource hubVnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${prefix}-hub-vnet'
  location: location
  properties: {
    addressSpace: { addressPrefixes: [ '10.0.0.0/16' ] }
    subnets: [
      { name: 'AzureFirewallSubnet'; properties: { addressPrefix: '10.0.0.0/24' } },
      { name: 'AzureBastionSubnet'; properties: { addressPrefix: '10.0.1.0/27' } },
      { name: 'shared-services'; properties: { addressPrefix: '10.0.2.0/24' } }
    ]
  }
}

output hubVnetId string = hubVnet.id
