
param appName string
param skuName string

@description('Name of the Azure Container Registry')
var containerRegistryName = '${appName}-cr'

@description('Create an Azure Container Registry')
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' = {
  name: containerRegistryName
  location: resourceGroup().location
  sku: {
    name: skuName
  }
  properties: {
    adminUserEnabled: false
  }
}
