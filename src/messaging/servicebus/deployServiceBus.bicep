@description('Name of the Service Bus namespace')
param namespaceName string

@allowed([
  'dev'
  'prod'
])
@description('The environment type for the service bus namespace')
param environmentType string = 'dev'

param tags object = {}

@description('Deploy a Service Bus namespace to Azure')
module serviceBus 'serviceBus.bicep' = {
  name: 'serviceBus'
  params: {
    namespaceName: namespaceName
    environmentType: environmentType
    tags: tags
  }
}

var queueName = '${namespaceName}-queue'

@description('Deploy a Service Bus queue to Azure')
module serviceBusQueue 'serviceBusQueue.bicep' = {
  name: 'serviceBusQueue'
  params: {
    namespaceName: serviceBus.outputs.name
    queueName: queueName
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}
