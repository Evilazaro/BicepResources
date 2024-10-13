using 'virtualNetwork.bicep'

var devSettings = {
  virtualNetworkName: 'myVnet'
  location: 'East US'
  addressPrefix: [
    '10.0.0.0/16'
  ]
  tags: {
    environment: 'dev'
    displayName: 'Development'
    division: 'Engineering'
    Company: 'Contoso'
    Team: 'DevOps'
    solution: 'ContosoApp'
  }
}

@description('The name of the virtual network')
param virtualNetworkName = devSettings.virtualNetworkName

@description('The location of the virtual network')
param location = devSettings.location

@description('The address prefix of the virtual network')
param addressPrefix = devSettings.addressPrefix

@description('The tags of the virtual network')
param tags  = devSettings.tags
