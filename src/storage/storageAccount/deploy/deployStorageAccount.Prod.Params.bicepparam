using 'deployStorage.bicep'

@description('The prefix for the storage account Prod environment')
var sufix = 'prod'

@description('The name of the solution that the storage account is for. The name will be used with the sufix for the storage account name')
var solutionName = 'eshopapp'

@description('The name of the storage account Prod environment')
var storageAccountName = '${solutionName}${sufix}storage'

// You must change the Identity Type to 'UserAssigned' if you want to use a user assigned managed identity for the storage account. If you want to use a system assigned managed identity, you can use the default value of 'SystemAssigned'.
@description('The identity type of the storage account')
var identityType = 'SystemAssigned'

@description('The settings for the prodelopment storage account')
var settings = {
  name: storageAccountName
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

@description('The user assigned managed identity resource IDs')
var userAssignedIdentityIds = (identityType == 'UserAssigned' ) ? {
  // Add the user assigned managed identity resource ID here. For example:
  //'/subscriptions/<YOUR-SUBSCRIPTION-ID>/resourceGroups/<YOUR-RESOURCEGROUP-NAME/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<YOUR-IDENTITY-NAME>': {}
}
: {}

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
param env = 'prod'
