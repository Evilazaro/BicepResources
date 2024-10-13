using 'storageAccount.bicep'

var prefix = 'prod'

@description('The settings for the development storage account')
var prodSettings =  {
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

param storageAccountName = prodSettings.name
param sku = prodSettings.sku
param storageKind = prodSettings.storageKind
param accesTier = prodSettings.accesTier
param tags = prodSettings.tags


