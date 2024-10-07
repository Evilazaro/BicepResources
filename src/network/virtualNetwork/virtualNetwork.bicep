@description('Deploy a virtual network to Azure')
param virtualNetworkName string = 'myVnet'

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

@description('The name of the virtual network')
output virtualNetworkName string = virtualNetwork.name

@description('The location of the virtual network')
output virtualNetworkLocation string = virtualNetwork.location

@description('The address prefix of the virtual network')
output virtualNetworkAddressPrefix string = virtualNetwork.properties.addressSpace.addressPrefixes[0]

@description('Deploy a Subnet to the virtual network')
module subnet './subNet.bicep' = {
  name: 'subnet'
  params: {
    virtualNetworkName: virtualNetwork.name
    subnetName: 'default'
    environmentType: environmentType
  }
}

@description('The name of the subnet')
output subnetName string = subnet.outputs.subnetName

@description('The address prefix of the subnet')
output subnetAddressPrefix string = subnet.outputs.subnetAddressPrefix

@description('The ID of the virtual network')
output virtualNetworkId string = virtualNetwork.id

@description('The ID of the subnet')
output subnetId string = subnet.outputs.subnetId
