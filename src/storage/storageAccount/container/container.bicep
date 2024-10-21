@description('Container Name')
param name string 

@description('Blob Name of an existent Blog Service')
param blobName string

@description('Storage Account Name of an existent Storage Account')
param storageAccountName string


@description('Get an Existent Blob Service')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
  scope:resourceGroup()
}

@description('Get an Existent Blob Service')
resource blob 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' existing = {
  name: blobName
  parent: storageAccount
}

@description('Deploy a container to Azure Storage Account')
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: name
  parent: blob
}
