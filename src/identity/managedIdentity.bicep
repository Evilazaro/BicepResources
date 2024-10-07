@description('Managed Identity Name')
param appName string

@description('Deploy a managed identity to Azure')
var managedIdentityName = '${appName}-mi'

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: managedIdentityName
  location: resourceGroup().location
}

@description('Managed Identity Principal Id')
output managedIdentityName string = managedIdentity.name

@description('Managed Identity Principal Id')
output managedIdentityPrincipalId string = managedIdentity.properties.principalId

@description('Managed Identity Tenant Id')
output managedIdentityTenantId string = managedIdentity.properties.tenantId

@description('Managed Identity Client Id')
output managedIdentityClientId string = managedIdentity.properties.clientId
