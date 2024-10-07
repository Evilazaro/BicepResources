@description('The name of the app the role assignment is being created for')
param appName string

@description('The name of the Managed Identity')
param managedIdentityName string

@description('The role definition ID for the role assignment')
param roleDefinitionId string

@description('Create a role assignment for a principal in a resource group')
var roleAssignmentName = '${appName}-role-assignment'

@description('Get the principal ID of the Managed Identity')
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' existing = {
  name: managedIdentityName
}

@description('Assign a role to a principal in a resource group')
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: roleAssignmentName
  scope: resourceGroup()
  properties: {
    principalId: managedIdentity.properties.principalId
    roleDefinitionId: roleDefinitionId
  }
}

@description('The ID of the role assignment')
output roleAssignmentId string = roleAssignment.id

@description('The name of the role assignment')
output roleAssignmentName string = roleAssignment.name

@description('The principal ID for the role assignment')
output roleAssignmentPrincipalId string = roleAssignment.properties.principalId

@description('The role definition ID for the role assignment')
output roleAssignmentRoleDefinitionId string = roleAssignment.properties.roleDefinitionId

@description('The scope of the role assignment')
output roleAssignmentScope string = roleAssignment.properties.scope
