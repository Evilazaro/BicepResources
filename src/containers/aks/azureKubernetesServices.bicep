param clusterName string = uniqueString('aks',resourceGroup().id)
param location string = resourceGroup().location

@allowed([
  '1.30.4'
  '1.30.3'
  '1.30.2'
  '1.30.1'
  '1.30.0'
  '1.29.8'
])
param kubernetesVersion string = '1.29.8'

@description('The initial pool configuration of the AKS cluster')
param initialPoolConfiguration object =  {
  name: '${clusterName}-NodePool'
  count: 3
  mode: 'System'
  vmSkuName: 'Standard_D2s_v3'
}

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
      vmSkuName: 'Standard_D2s_v3'
      count: 3
    }
    networkConfiguration:{
      cloudServicesNetworkId: 'cloudServicesNetworkId'
      cniNetworkId: 'cniNetworkId'

    }
    aadConfiguration:{
      adminGroupObjectIds: [
        'adminGroupObjectIds'
      ]

    }
    administratorConfiguration:{

    }
    managedResourceGroupConfiguration:{
      name: uniqueString(clusterName,  'managedResourceGroup')
      location: location
    }
  }
}
