@description('Name of the Blob Service')
param name string

@description('Name of the Storage Account')
param storageAccountName string

@description('Gets an Existent Storage Account')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

@description('Deploy a Blob Service to Azure with a unique name')
resource blob 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: name
  parent: storageAccount
}
