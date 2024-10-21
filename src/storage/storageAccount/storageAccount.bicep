@description('The name of the storage account')
@maxLength(21)
@minLength(3)
param name string

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
param kind string

@allowed([
  'Hot'
  'Cool'
])
param accessTier string

@allowed([
  'SystemAssigned'
  'UserAssigned'
  'None'
])
@description('The identity type of the storage account')
param identity string

@description('The tags of the storage account')
param tags object

@description('The user assigned managed identity resource IDs')
param userAssignedIdentities object

@description('Deploy a storage account to Azure with a unique name')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: name
  location: resourceGroup().location
  sku: {
    name: sku
  }
  kind: kind
  properties: {
    accessTier: accessTier    
  }
  identity: (identity == 'SystemAssigned' || identity == 'None')
    ? {
        type: identity
      }
    : {
        type: identity
        userAssignedIdentities: userAssignedIdentities
      }
  tags: tags
}

@description('Stoarge account name')
output storageAccountName string = storageAccount.name

@description('Storage account resource ID')
output storageAccountResourceId string = storageAccount.id
