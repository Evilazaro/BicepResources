param name string
param storageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
}

resource table 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  name: name
  parent: storageAccount
}
