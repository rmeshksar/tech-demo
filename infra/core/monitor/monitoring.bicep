param location string = resourceGroup().location
param logAnalyticsName string
param applicationInsightName string
param tags object = {}

module logAnalytics './loganalytics.bicep' = {
  name: 'loganalytics'
  params: {
    location: location
    name: logAnalyticsName
    tags: tags
  }
}

module applicationInsights './applicationinsight.bicep' = {
  name: 'applicationinsights'
  params: {
    name: applicationInsightName
    location: location
    tags: tags
    logAnalyticsWorkspaceId: logAnalytics.outputs.id
  }
}

output applicationInsightName string = applicationInsights.outputs.name


