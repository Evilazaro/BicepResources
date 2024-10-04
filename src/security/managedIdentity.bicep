@description('Managed Identity Name')
param managedIdentityName string = uniqueString(resourceGroup().id, 'mi')


resource securityGroup 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: managedIdentityName
  location: resourceGroup().location
}

@description('Managed Identity Principal Id')
output managedIdentityName string = securityGroup.name

@description('Managed Identity Principal Id')
output managedIdentityPrincipalId string = securityGroup.properties.principalId

@description('Managed Identity Tenant Id')
output managedIdentityTenantId string = securityGroup.properties.tenantId

@description('Managed Identity Client Id')
output managedIdentityClientId string = securityGroup.properties.clientId
