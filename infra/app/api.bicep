param serviceName string = 'api'
param location string = resourceGroup().location
param environmentName string
param tags object = {}

// param applicationInsightName string = ''
param appServicePlanId string = ''

var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

module api '../core/host/appservice.bicep' = {
  name: '${serviceName}-app-module'
  params: {
    name: 'app-api${resourceToken}'
    location: location
    tags: union(tags, { 'azd-service-name': serviceName })
    // applicationInsightName: applicationInsightName
    appServicePlanId: appServicePlanId
    linuxFxVersion: 'DOTNETCORE|7.0'
  }
}
