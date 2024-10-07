@description('The name of the app the network interface is being deployed for')
param appName string

@allowed([
  'dev'
  'prod'
])
@description('The type of the environment the network interface is being deployed to')
param environmentType string = 'dev'

@description('Name of an Existent Virtual Network')
var vnetName = '${appName}-vnet'

@description('Get the virtual network already created')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' existing = {
  name: vnetName
}

@description('Get the subnet already created')
module subnet './subNet.bicep' = {
  name: 'subnet'
  params: {
    virtualNetworkName: virtualNetwork.name
    subnetAddressPrefix: '10.1.0.0/24'
    environmentType: environmentType
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: '${appName}-nic'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: '${appName}-ipconfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet.outputs.subnetId
          }
        }
      }
    ]
  }
  dependsOn: [
    subnet
  ]
}
