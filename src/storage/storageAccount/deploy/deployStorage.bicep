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

module storageAccount '../storageAccount.bicep' = {
  name: 'storageAccount'
  params: {
    name: name
    sku: sku
    kind: kind
    accessTier: accessTier
    identity: identity
    tags: tags
    userAssignedIdentities: userAssignedIdentities
  }
}

module blob '../blob/blob.bicep' = {
  name: 'blob'
  params: {
    storageAccountName: storageAccount.outputs.storageAccountName
  }
  dependsOn: [
    storageAccount
  ]
}

@description('The name of the Blob Service')
output blobName string = blob.outputs.blobName

module container '../container/container.bicep' = {
  name: 'container'
  params: {
    name: '${storageAccount.outputs.storageAccountName}-container'
    blobName:'default'
    storageAccountName: storageAccount.outputs.storageAccountName
  }
 dependsOn: [
    blob
  ]
}

@description('The name of the container')
output containerName string = container.outputs.containerName

module queue '../queue/queue.bicep' = {
  name: 'queue'
  params: {
    storageAccountName: storageAccount.outputs.storageAccountName
  }
  dependsOn: [
    storageAccount
  ]
}

@description('The name of the queue')
output queueName string = queue.outputs.queueName

// module table '../table/table.bicep' = {
//   name: 'table'
//   params: {
//     name: '${storageAccount.outputs.storageAccountName}-table'
//     storageAccountName: storageAccount.outputs.storageAccountName
//   }
//   dependsOn: [
//     storageAccount
//   ]
// }
