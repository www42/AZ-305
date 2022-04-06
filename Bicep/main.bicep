targetScope = 'managementGroup'

param mgName string = newGuid()
param mgDisplayName string

resource mg 'Microsoft.Management/managementGroups@2021-04-01' = {
  scope: tenant()
  name: mgName
  properties: {
    displayName: mgDisplayName
  }
}

output mgId string = mg.id
