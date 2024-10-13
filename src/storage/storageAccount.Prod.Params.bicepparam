using 'storageAccount.bicep'

var prefix = 'prod'

@description('The settings for the development storage account')
var devSettings =  {
  name: '${prefix}eshopstorage'
  sku: 'Premium_LRS'
  storageKind: 'StorageV2'
  accesTier: 'Hot'
  tags: {
    environment: 'prod'
    displayName: 'Development'
    division: 'Engineering'
    Company: 'Contoso'
    Team: 'DevOps'
    billing: 'internal'
  }
}

param storageAccountName = devSettings.name
param sku = devSettings.sku
param storageKind = devSettings.storageKind
param accesTier = devSettings.accesTier
param tags = devSettings.tags


