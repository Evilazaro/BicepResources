@description('Name of the application that the subnet is being deployed to')
param appName string

@description('The address prefix of the subnet')
param subnetAddressPrefix string = '10.0.0.0/24'

@description('The type of the environment the subnet is being deployed to')
param environmentType string = 'dev'

@description('Create a subnet in a virtual network')
var virtualNetworkName = '${appName}-vnet'

@description('The virtual network to deploy the subnet to')
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' existing = {
  name: virtualNetworkName
}

@description('The security rules of the network security group')
var securityRules = (environmentType == 'dev')
  ? [
      {
        name: 'AllowSSH'
        properties: {
          priority: 1000
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: subnetAddressPrefix
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowSSHOutbound'
        properties: {
          priority: 1001
          direction: 'Outbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowTcp'
        properties: {
          priority: 1030
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: subnetAddressPrefix
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowTcpOutbound'
        properties: {
          priority: 1031
          direction: 'Outbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowUdp'
        properties: {
          priority: 1040
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Udp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: subnetAddressPrefix
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowUdpOutbound'
        properties: {
          priority: 1041
          direction: 'Outbound'
          access: 'Allow'
          protocol: 'Udp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowHTTP'
        properties: {
          priority: 1010
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowHTTPOutbound'
        properties: {
          priority: 1011
          direction: 'Outbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowHTTPS'
        properties: {
          priority: 1020
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowHTTPSOutbound'
        properties: {
          priority: 1021
          direction: 'Outbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  : [
      {
        name: 'AllowHTTP'
        properties: {
          priority: 1010
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowHTTPOutbound'
        properties: {
          priority: 1011
          direction: 'Outbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowHTTPS'
        properties: {
          priority: 1020
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'AllowHTTPSOutbound'
        properties: {
          priority: 1021
          direction: 'Outbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]

@description('Deploy a network security group to the subnet')
module nsg 'nsg.bicep' = {
  name: 'networkSecurityGroup'
  params: {
    nsgName: '${subnetName}-nsg'
    securityRules: securityRules
    tags: {}
  }
}

@description('The name of the network security group')
output nsgName string = nsg.outputs.nsgName

@description('The ID of the network security group')
output nsgId string = nsg.outputs.nsgId

@description('The security rules of the network security group')
output nsgSecurityRules array = nsg.outputs.nsgSecurityRules

@description('The location of the network security group')
output nsgLocation string = nsg.outputs.nsgLocation

@description('The name of the subnet')
var subnetName = '${virtualNetworkName}-subnet'

@description('Deploy a subnet to a virtual network')
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: subnetName
  properties: {
    addressPrefix: subnetAddressPrefix
    networkSecurityGroup: {
      id: nsg.outputs.nsgId
    }
  }
  parent: virtualNetwork
  dependsOn: [
    nsg
  ]
}

@description('The name of the subnet')
output subnetName string = subnet.name

@description('The address prefix of the subnet')
output subnetAddressPrefix string = subnet.properties.addressPrefix

@description('The ID of the virtual network')
output virtualNetworkId string = virtualNetwork.id

@description('The ID of the subnet')
output subnetId string = subnet.id