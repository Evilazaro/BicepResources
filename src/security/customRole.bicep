param customRoleName string
param customRoleDescription string

// Replace the assignableScopes variable with the assignable scopes of the custom role
@description('The assignable scopes of the custom role')
var assignableScopes = [
  '/subscriptions/00000000-0000-0000-0000-000000000000'
]

// Replace the permissions variable with the permissions of the custom role
@description('The permissions of the custom role')
var permissions = [
  {
    actions: [
      'Microsoft.Storage/storageAccounts/read'
      'Microsoft.Storage/storageAccounts/write'
    ]
    notActions: []
    dataActions: []
    notDataActions: []
  }
  {
    actions: [
      'Microsoft.Network/virtualNetworks/read'
      'Microsoft.Network/virtualNetworks/write'
    ]
    notActions: []
    dataActions: []
    notDataActions: []
  }
]


@description('Create a custom role in Azure')
resource customRole 'Microsoft.Authorization/roleDefinitions@2022-05-01-preview' = {
  name: customRoleName
  properties: {
    roleName: customRoleName
    description: customRoleDescription
    assignableScopes: assignableScopes
    permissions: permissions
    type: 'CustomRole'
  }
}


@description('The ID of the custom role')
output customRoleId string = customRole.id

@description('The name of the custom role')
output customRoleName string = customRole.properties.roleName

@description('The description of the custom role')
output customRoleDescription string = customRole.properties.description

@description('The assignable scopes of the custom role')
output customRoleAssignableScopes array = customRole.properties.assignableScopes

@description('The permissions of the custom role')
output customRolePermissions array = customRole.properties.permissions
