@description('Queue name')
param name string

@description('Storage account name')
param storageAccountName string

@description('Get the existent storage account resource')
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
  scope: resourceGroup()
}

@description('Deploy a queue service in the storage account')
resource queueServices 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

@description('Deploy a queue in the queue service')
resource queue 'Microsoft.Storage/storageAccounts/queueServices/queues@2023-05-01' = {
  name: name
  parent: queueServices
}

@description('Queue name')
output queueName string = queue.name
