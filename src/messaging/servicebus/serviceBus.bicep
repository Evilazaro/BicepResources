@description('The name of the Service Bus namespace')
param namespaceName string = 'myServiceBusNamespace'

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
  name: 'Standard'
  tier: 'Standard'
} : {
  name: 'Premium'
  tier: 'Premium'
}

@description('Deploy a Service Bus namespace to Azure')
resource serviceBus 'Microsoft.ServiceBus/namespaces@2023-01-01-preview' = {
  name: namespaceName
  location: resourceGroup().location
  sku: sku
  tags: tags
}

@description('The service bus namespace name')
output name string = serviceBus.name

@description('The service bus namespace resource')
output serviceBus object = serviceBus

@description('The service bus namespace sku')
output sku object = sku


