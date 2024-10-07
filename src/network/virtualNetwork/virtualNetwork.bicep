@description('The name of the app the virtual network is being deployed for')
param appName string 

@description('The type of the environment the virtual network is being deployed to')
param environmentType string = 'dev'

@description('The location of the virtual network')
param location string = resourceGroup().location

@description('The address prefix of the virtual network')
param addressPrefix string = '10.0.0.0/16'

@description('The tags of the virtual network')
param tags object = {
  
}

@description('Deploy a virtual network to Azure')
var virtualNetworkName = '${appName}-vnet'

@description('Deploy a virtual network to Azure')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
  }
  tags: tags  
}

@description('The Subnet Address Prefix')
var subnetAddressPrefix  = '10.0.0.0/24'

module subnet './subNet.bicep' = {
  name: 'subnet'
  params: {
    virtualNetworkName: virtualNetwork.name
    environmentType: environmentType
    subnetAddressPrefix: subnetAddressPrefix
  }
}
