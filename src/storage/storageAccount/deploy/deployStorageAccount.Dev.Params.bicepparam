using 'deployStorage.bicep'

@description('The prefix for the storage account Dev environment')
var sufix = 'dev'

@description('The name of the solution that the storage account is for. The name will be used with the sufix for the storage account name')
var solutionName = 'eshopapp'

var storageAccountName = '${solutionName}${sufix}storage'

@description('The settings for the Development storage account')
var settings =  {
  name:storageAccountName
  sku: 'Standard_LRS'
  kind: 'StorageV2'
  accesTier: 'Hot'
  tags: {
    environment: sufix
    displayName: 'Development'
    division: 'Engineering'
    Company: 'Contoso'
    Team: 'Platform'
    billing: 'internal'
  }
}

@description('The user assigned managed identity resource IDs')
var userAssignedIdentityIds = {}

@description('The name of the storage account')
param name = settings.name

@description('The storage account sku')
param sku = settings.sku

@description('The storage account kind')
param kind = settings.kind

@description('The storage account access tier')
param accessTier = settings.accesTier

@description('The storage account identity type')
param identity = 'None'

@description('The user assigned managed identity resource IDs')
param userAssignedIdentities = userAssignedIdentityIds

@description('The storage account tags')
param tags = settings.tags

@allowed([
  'dev'
  'prod'
])
@description('Environment name')
param env = 'dev'


