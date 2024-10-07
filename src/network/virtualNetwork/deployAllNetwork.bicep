param appName string 

@description('Deploy a Virtual Network to Azure')
module virtualNetwork './virtualNetwork.bicep' = {
  name: 'virtualNetwork'
  params: {
    appName: appName
  }
}

@description('The security rules of the network security group')
var securityRules = [
  {
    name: 'Allow-SSH'
    properties: {
      protocol: 'Tcp'
      sourcePortRange: '*'
      destinationPortRange: '22'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
      access: 'Allow'
      priority: 100
      direction: 'Inbound'
    }
  }
  {
    name: 'Allow-HTTP'
    properties: {
      protocol: 'Tcp'
      sourcePortRange: '*'
      destinationPortRange: '80'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
      access: 'Allow'
      priority: 110
      direction: 'Inbound'
    }
  }
  {
    name: 'Allow-HTTPS'
    properties: {
      protocol: 'Tcp'
      sourcePortRange: '*'
      destinationPortRange: '443'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
      access: 'Allow'
      priority: 120
      direction: 'Inbound'
    }
  }
]

@description('Deploy a Network Security Group to Azure')
module nsg '../../security/nsg.bicep' = {
  name: 'nsg'
  params: {
    nsgName: appName
    securityRules: securityRules
    tags: {}
  }
}

@description('Deploy a Subnet to Azure')
module subnet './subNet.bicep' = {
  name: 'subnet'
  params: {
    virtualNetworkName: virtualNetwork.outputs.virtualNetworkName
    nsgId: nsg.outputs.nsgId
  }
  dependsOn: [
    virtualNetwork
    nsg
  ]
}

module networkInterface './networkInterface.bicep' = {
  name: 'networkInterface'
  params: {
    subnetName: subnet.outputs.subnetName
  }
  dependsOn: [
    virtualNetwork
    subnet
  ]
}
