using 'storageAccount.bicep'

var prefix = 'dev'

@description('The settings for the development storage account')
var devSettings =  {
  name: '${prefix}eshopstorage'
  sku: 'Standard_LRS'
  storageKind: 'StorageV2'
  accesTier: 'Hot'
  tags: {
    environment: 'dev'
    displayName: 'Development'
    division: 'Engineering'
    Company: 'Contoso'
    Team: 'DevOps'
  }
}

param storageAccountName = devSettings.name
param sku = devSettings.sku
param storageKind = devSettings.storageKind
param accesTier = devSettings.accesTier
param tags = devSettings.tags


