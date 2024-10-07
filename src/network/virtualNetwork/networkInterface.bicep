@description('Name of an Existent Virtual Network')
param subnetName string

@description('Existent Subnet to Deploy a Network Interface')
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' existing = {
  name: subnetName
}

@description('Deploy a Network Interface to Azure')
resource networkInterface 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: '${subnetName}-nic'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: null
        }
      }
    ]
  }
}
