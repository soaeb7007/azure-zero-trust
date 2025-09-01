@description('Zero Trust baseline - hub/spoke + Firewall + Bastion + Sentinel')
targetScope = 'resourceGroup'

@description('Prefix for resource names')
param prefix string = 'zt'
@description('Location for all resources')
param location string = resourceGroup().location

module hub './hubSpoke.bicep' = {
  name: '${prefix}-hub'
  params: {
    prefix: prefix
    location: location
  }
}

module firewall './firewall.bicep' = {
  name: '${prefix}-afw'
  params: {
    prefix: prefix
    location: location
    hubVnetId: hub.outputs.hubVnetId
  }
}

module bastion './bastion.bicep' = {
  name: '${prefix}-bastion'
  params: {
    prefix: prefix
    location: location
    hubVnetId: hub.outputs.hubVnetId
  }
}

module sentinel './sentinel.bicep' = {
  name: '${prefix}-sentinel'
  params: {
    prefix: prefix
    location: location
  }
}
