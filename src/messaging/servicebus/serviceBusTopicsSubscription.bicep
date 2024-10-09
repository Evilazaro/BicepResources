param subscriptionName string
param topicName string

@description('Existent topic for the Rule')
resource topic 'Microsoft.ServiceBus/namespaces/topics@2023-01-01-preview' existing = {
  name: topicName
}

@description('Deploy a Service Bus Topic Subscription')
resource topicSubscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2023-01-01-preview' = {
  name: subscriptionName
  parent: topic
}

@description('Subscription Name')
output subscriptionName string = topicSubscription.name
