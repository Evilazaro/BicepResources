@description('Service Bus Namespace name')
param namespaceName string

@description('Service Bus Topic name')
param name string

@description('The environment type for the service bus namespace')
param environmentType string = 'dev'

@description('Existent Service Bus Deployed')
resource serviceBus 'Microsoft.ServiceBus/namespaces@2023-01-01-preview' existing = {
  name: namespaceName
}

@description('The default configuration for a Service Bus topic')
var defaultTopicConfig = (environmentType == 'dev') ?  {
  MaxSizeInMegabytes: 1024
  EnablePartitioning: false
  RequiresDuplicateDetection: false
  DuplicateDetectionHistoryTimeWindow: 'PT10M'
  EnableBatchedOperations: true
  Status: 'Active'
}
: {
  MaxSizeInMegabytes: 2024
  EnablePartitioning: true
  RequiresDuplicateDetection: true
  DuplicateDetectionHistoryTimeWindow: 'PT10M'
  EnableBatchedOperations: true
  Status: 'Active'
}


@description('Deploy a Service Bus topic to Azure')
resource topic 'Microsoft.ServiceBus/namespaces/topics@2023-01-01-preview' = {
  name: name
  parent: serviceBus
  properties: {
    maxSizeInMegabytes: defaultTopicConfig.MaxSizeInMegabytes
    enablePartitioning: defaultTopicConfig.EnablePartitioning
    requiresDuplicateDetection: defaultTopicConfig.RequiresDuplicateDetection
    duplicateDetectionHistoryTimeWindow: defaultTopicConfig.DuplicateDetectionHistoryTimeWindow
    enableBatchedOperations: defaultTopicConfig.EnableBatchedOperations
    status: defaultTopicConfig.Status
  }
}
