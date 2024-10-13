using 'networkSecurityGroup.bicep'

@description('The settings for the development network security group')
var prodSettings = {
  name: 'myNsg'
  securityRules: [
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
  tags: {
    environment: 'Prod'
    displayName: 'Development'
    division: 'Engineering'
    Company: 'Contoso'
    Team: 'DevOps'
    solution: 'ContosoApp'
  }
}

@description('The name of the network security group')
param nsgName = prodSettings.name

@description('The security rules of the network security group')
param securityRules = prodSettings.securityRules

@description('The tags of the network security group')
param tags = prodSettings.tags
