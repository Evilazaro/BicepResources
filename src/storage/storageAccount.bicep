@description('The name of the storage account')
@maxLength(21)
@minLength(3)
param storageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param sku string

@allowed([
  'StorageV2'
  'Storage'
  'BlobStorage'
])
@description('The kind of the storage account')
param storageKind string

@description('The access tier of the storage account')
@allowed([
  'Hot'
  'Cool'
])
param accesTier string

@description('The tags of the storage account')
param tags object 

@description('Deploy a storage account to Azure with a unique name')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: resourceGroup().location
  sku: {
    name: sku
  }
  kind: storageKind
  properties: {
    accessTier: accesTier
  }
  tags: tags
}

