param storageAccountName string = uniqueString(resourceGroup().id, 'stg')
param location string = resourceGroup().location

@description('The SKU of the storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param sku string = 'Standard_LRS'

@description('The kind of the storage account')
@allowed([
  'StorageV2'
  'Storage'
  'BlobStorage'
])
param kind string = 'StorageV2'

@description('The access tier of the storage account')
@allowed([
  'Hot'
  'Cool'
])
param accesTier string = 'Hot'

@description('The tags of the storage account')
param tags object = {
  
}

@description('Deploy a storage account to Azure with a unique name')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: sku
  }
  kind: kind
  properties: {
    accessTier: accesTier
  }
  tags: tags
}

@description('The name of the storage account')
output storageAccountName string = storageAccount.name

@description('The location of the storage account')
output storageAccountLocation string = storageAccount.location

@description('The SKU of the storage account')
output storageAccountSku string = storageAccount.sku.name

@description('The kind of the storage account')
output storageAccountKind string = storageAccount.kind

@description('The access tier of the storage account')
output storageAccountAccessTier string = storageAccount.properties.accessTier

@description('The tags of the storage account')
output storageAccountTags object = storageAccount.tags

