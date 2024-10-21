using 'storageAccount.bicep'

@description('The prefix for the storage account Prod environment')
var sufix = 'prod'

@description('The name of the solution that the storage account is for. The name will be used with the sufix for the storage account name')
var solutionName = 'eshopapp'

var storageAccountName = '${solutionName}${sufix}storage'

@description('The settings for the prodelopment storage account')
var settings =  {
  name:storageAccountName
  sku: 'Premium_LRS'
  kind: 'StorageV2'
  accesTier: 'Hot'
  tags: {
    environment: sufix
    displayName: 'Production'
    division: 'Engineering'
    Company: 'Contoso'
    Team: 'Platform'
    billing: 'external'
  }
}

@description('The name of the storage account')
param name = settings.name

@description('The storage account sku')
param sku = settings.sku

@description('The storage account kind')
param kind = settings.kind

@description('The storage account access tier')
param accesTier = settings.accesTier

@description('The storage account tags')
param tags = settings.tags


