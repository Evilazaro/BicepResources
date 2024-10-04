param clusterName string = uniqueString('aks',resourceGroup().id)
param location string = resourceGroup().location

@allowed([
  'dev'
  'prod'
])
@description('The environment type of the AKS cluster. This will determine the initial pool configuration')
param environmentType string = 'dev'

@description('The initial pool configuration of the AKS cluster')
var initialPoolConfiguration = (environmentType == 'prod') ? {
  name: '${clusterName}-NodePool'
  count: 3
  mode: 'System'
  vmSkuName: 'Standard_D2s_v3'
} : {
  name: '${clusterName}-NodePool'
  count: 1
  mode: 'System'
  vmSkuName: 'Standard_D2s_v3'
}

@allowed([
  '1.30.4'
  '1.30.3'
  '1.30.2'
  '1.30.1'
  '1.30.0'
])
@description('The version of Kubernetes to use for the AKS cluster')
param kubernetesVersion string = '1.30.4'

@allowed([
  '1'
  '2'
  '3'
])
@description('The availability zones of the AKS cluster')
param availabilityZones array = [
  '1'
  '2'
  '3'
]

@description('The ID of the cloud services network')
param cloudServicesNetworkId string

@description('The ID of the CNI network')
param cniNetworkId string

@description('Deploy an Azure Kubernetes Service cluster to Azure')
resource aks 'Microsoft.NetworkCloud/kubernetesClusters@2024-06-01-preview' = {
  name: clusterName
  location: location
  extendedLocation: {
    name: location
    type: 'EdgeZone'
  }
  properties:{
    kubernetesVersion: kubernetesVersion
    initialAgentPoolConfigurations: [
      {
        name: initialPoolConfiguration.name
        count: initialPoolConfiguration.count
        mode: initialPoolConfiguration.mode
        vmSkuName: initialPoolConfiguration.vmSkuName
      }
    ]
    controlPlaneNodeConfiguration: {
      vmSkuName: initialPoolConfiguration.vmSkuName
      count: initialPoolConfiguration.count
      availabilityZones: availabilityZones
    }
    networkConfiguration:{
      cloudServicesNetworkId: cloudServicesNetworkId
      cniNetworkId: cniNetworkId

    }
    administratorConfiguration:{
      adminUsername: '${clusterName}Admin'
    }
    managedResourceGroupConfiguration:{
      name: uniqueString(clusterName,  'managedResourceGroup')
      location: location
    }
  }
}

@description('The name of the AKS cluster')
output clusterName string = aks.name

@description('The location of the AKS cluster')
output clusterLocation string = aks.location

@description('The version of Kubernetes to use for the AKS cluster')
output clusterKubernetesVersion string = aks.properties.kubernetesVersion

@description('The initial pool configuration of the AKS cluster')
output clusterInitialPoolConfiguration object = initialPoolConfiguration

@description('The control plane node configuration of the AKS cluster')
output clusterControlPlaneNodeConfiguration object = aks.properties.controlPlaneNodeConfiguration

@description('The network configuration of the AKS cluster')
output clusterNetworkConfiguration object = aks.properties.networkConfiguration

@description('The AAD configuration of the AKS cluster')
output clusterAadConfiguration object = aks.properties.aadConfiguration

@description('The administrator configuration of the AKS cluster')
output clusterAdministratorConfiguration object = aks.properties.administratorConfiguration

@description('The managed resource group configuration of the AKS cluster')
output clusterManagedResourceGroupConfiguration object = aks.properties.managedResourceGroupConfiguration
