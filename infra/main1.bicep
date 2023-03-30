targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

param resourceGroupName string = ''
param appServiceName string = ''
param applicationInsightName string = ''
param logAnalyticsName string = ''

var tags = { 'azd-env-name': environmentName }

var abbrs = loadJsonContent('./abbreviations.json')
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : '${abbrs.resourcesResourceGroups}${environmentName}'
  location: location
  tags: tags  
}

module appServicePlan './core/host/appserviceplan.bicep' = {
  name: 'appserviceplan'
  scope: rg
  params: {
    location: location
    kind: 'linux'
    name: !empty(appServiceName) ? appServiceName : '${abbrs.webServerFarms}${resourceToken}'
    sku: {
      name: 'F1'
    }
  }
}

module monitoring './core/monitor/monitoring.bicep' = {
  name: 'monitoring'
  scope: rg
  params: {
    location: location
    tags: tags
    applicationInsightName: !empty(applicationInsightName) ? applicationInsightName : '${abbrs.insightsComponents}${resourceToken}'
    logAnalyticsName: !empty(logAnalyticsName) ? logAnalyticsName : '${abbrs.operationalInsightsWorkspaces}${resourceToken}'
  }
}

output APPLICATIONINSIGHTS_NAME string = monitoring.outputs.applicationInsightName
output APPLICATTION_SERVICE_PLAN_ID string = appServicePlan.outputs.id
