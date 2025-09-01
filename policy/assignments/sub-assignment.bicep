targetScope = 'subscription'

@description('Policy definition names')
param policyDefNames array = [
  'deny-public-storage',
  'require-private-endpoints',
  'deny-public-ip-on-vm'
]

resource defs 'Microsoft.Authorization/policyDefinitions@2021-06-01' existing = [for n in policyDefNames: {
  name: n
}]

resource assignments 'Microsoft.Authorization/policyAssignments@2021-06-01' = [for (defn, i) in defs: {
  name: 'enforce-${defn.name}'
  properties: {
    displayName: 'Enforce ${defn.name}'
    policyDefinitionId: defn.id
    enforcementMode: 'Default'
  }
}]
