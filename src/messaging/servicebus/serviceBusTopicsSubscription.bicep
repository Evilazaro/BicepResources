param subscriptionName string

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
