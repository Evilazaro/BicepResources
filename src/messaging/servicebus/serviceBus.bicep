@description('The name of the Service Bus namespace')
param serviceBusNamespaceName string = 'myServiceBusNamespace'

@allowed([
  'dev'
  'prod'
])
@description('The environment type for the service bus namespace')
param environmentType string = 'dev'

@description('The tags for the Service Bus namespace')
param tags object = {
  
}

var sku = environmentType == 'dev' ? {
  name: 'Basic'
  tier: 'Basic'
} : {
  name: 'Standard'
  tier: 'Standard'
}

@description('Deploy a Service Bus namespace to Azure')
resource serviceBus 'Microsoft.ServiceBus/namespaces@2023-01-01-preview' = {
  name: serviceBusNamespaceName
  location: resourceGroup().location
  sku: sku
  tags: tags
}
