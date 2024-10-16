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
    sku: {
      name: 'Standard'
      tier: 'Standard'
      capacity: 1
    }
    tags: tags
  }
}

var queueName = '${namespaceName}-queue'

@description('Deploy a Service Bus queue to Azure')
module queue 'serviceBusQueue.bicep' = {
  name: 'serviceBusQueue'
  params: {
    namespaceName: serviceBus.outputs.name
    name: queueName
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

var topicName = '${namespaceName}topic'

@description('Deploy a Service Bus topic to Azure')
module topic 'serviceBusTopic.bicep' = {
  name: 'serviceBusTopic'
  params: {
    namespaceName: serviceBus.outputs.name
    name: topicName
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

resource newtopic 'Microsoft.ServiceBus/namespaces/topics@2023-01-01-preview' existing = {
  name: topicName
}

resource subscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2023-01-01-preview' = {
  name: 'mySubscription'
  parent: newtopic
}

