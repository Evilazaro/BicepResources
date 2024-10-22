@description('Name of the Storage Account')
param storageAccountName string

@description('Gets an Existent Storage Account')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
  scope:resourceGroup()
}

@description('Deploy a Blob Service to Azure with a unique name')
resource blob 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

@description('Blob Service name')
output blobName string = blob.name
