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
module queue 'serviceBusQueue.bicep' = {
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

@description('Deploy a Service Bus queue to Azure')
module queue1 'serviceBusQueue.bicep' = {
  name: 'serviceBusQueue1'
  params: {
    namespaceName: serviceBus.outputs.name
    queueName: '${namespaceName}-queue1'
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

@description('Deploy a Service Bus queue to Azure')
module queue2 'serviceBusQueue.bicep' = {
  name: 'serviceBusQueue2'
  params: {
    namespaceName: serviceBus.outputs.name
    queueName: '${namespaceName}-queue2'
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

@description('Deploy a Service Bus queue to Azure')
module queue3 'serviceBusQueue.bicep' = {
  name: 'serviceBusQueue3'
  params: {
    namespaceName: serviceBus.outputs.name
    queueName: '${namespaceName}-queue3'
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
    topicName: topicName
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

@description('Deploy a Service Bus topic to Azure')
module topic1 'serviceBusTopic.bicep' = {
  name: 'serviceBusTopic1'
  params: {
    namespaceName: serviceBus.outputs.name
    topicName: '${namespaceName}topic1'	
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

@description('Deploy a Service Bus topic to Azure')
module topic2 'serviceBusTopic.bicep' = {
  name: 'serviceBusTopic2'
  params: {
    namespaceName: serviceBus.outputs.name
    topicName: '${namespaceName}topic2'
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

@description('Deploy a Service Bus topic to Azure')
module topic3 'serviceBusTopic.bicep' = {
  name: 'serviceBusTopic3'
  params: {
    namespaceName: serviceBus.outputs.name
    topicName: '${namespaceName}topic3'
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}

@description('Deploy a Service Bus topic to Azure')
module topic4 'serviceBusTopic.bicep' = {
  name: 'serviceBusTopic4'
  params: {
    namespaceName: serviceBus.outputs.name
    topicName: '${namespaceName}topic4'
    environmentType: environmentType
  }
  dependsOn: [
    serviceBus
  ]
}
