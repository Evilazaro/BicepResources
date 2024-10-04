@description('Create a subnet in a virtual network')
param virtualNetworkName string

@description('The name of the subnet')
param subnetName string = 'mySubnet'

@description('The address prefix of the subnet')
param subnetAddressPrefix string = '10.0.0.0/24'

@description('The virtual network to deploy the subnet to')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' existing = {
  name: virtualNetworkName
}

@description('Deploy a subnet to a virtual network')
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: subnetName
  properties: {
    addressPrefix: subnetAddressPrefix
  }
  parent: virtualNetwork
}

@description('The name of the subnet')
output subnetName string = subnet.name

@description('The address prefix of the subnet')
output subnetAddressPrefix string = subnet.properties.addressPrefix

@description('The ID of the virtual network')
output virtualNetworkId string = virtualNetwork.id

@description('The ID of the subnet')
output subnetId string = subnet.id


