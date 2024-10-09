param serviceBusNamespaceName string
param topicName string


resource topicSubscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2023-01-01-preview' = {
  name: '${serviceBusNamespaceName}/${topicName}/mySubscription'
  parent: serviceBusNamespace
  properties: {
    lockDuration: 'PT5M'
    maxDeliveryCount: 10
    deadLetteringOnMessageExpiration: false
    enableBatchedOperations: true
    autoDeleteOnIdle: 'P10675199DT2H48M5.4775807S'
    forwardDeadLetteredMessagesTo: null
    forwardTo: null
    userMetadata: null
  }
}

resource serviceBusTopic 'Microsoft.EventGrid/topics@2024-06-01-preview' existing = {
  name: topicName
}

resource serviceBusRule 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2023-01-01-preview' = {
  name: '${serviceBusNamespace.name}/myTopic/mySubscription/myRule'
  parent: serviceBusNamespace
  properties: {
    filterType: 'SqlFilter'
    sqlFilter: {
      sqlExpression: 'myProperty = @myValue'
    }
  }
}
