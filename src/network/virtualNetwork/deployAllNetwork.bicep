param appName string 
param environmentType string = 'dev'

module virtualNetwork './virtualNetwork.bicep' = {
  name: 'virtualNetwork'
  params: {
    appName: appName
    environmentType: environmentType
  }
}
