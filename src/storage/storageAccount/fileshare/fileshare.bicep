param name string
param storageAccountName string
@allowed([
  'Hot'
  'Cool'
])
param accesTier string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name: storageAccountName
  scope: resourceGroup()
}

resource fileShareService 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  name: name
  parent: fileShareService
  properties:{
    accessTier: accesTier
  }
}

@description('The name of the file share')
output fileShareName string = fileShare.name
