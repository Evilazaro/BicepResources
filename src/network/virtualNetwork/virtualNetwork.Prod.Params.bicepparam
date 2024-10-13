using 'virtualNetwork.bicep'

var prodSettings = {
  virtualNetworkName: 'myVnet'
  location: 'westus3'
  addressPrefix: [
    '10.0.0.0/16'
  ]
  tags: {
    environment: 'Prod'
    displayName: 'Development'
    division: 'Engineering'
    Company: 'Contoso'
    Team: 'DevOps'
    solution: 'ContosoApp'
  }
}

@description('The name of the virtual network')
param virtualNetworkName = prodSettings.virtualNetworkName

@description('The location of the virtual network')
param location = prodSettings.location

@description('The address prefix of the virtual network')
param addressPrefix = prodSettings.addressPrefix

@description('The tags of the virtual network')
param tags  = prodSettings.tags
