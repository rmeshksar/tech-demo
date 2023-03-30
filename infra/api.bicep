param location string
param environmentName string

var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'plan-${resourceToken}'
  location: location
  kind: 'linux'
  tags: {}
  properties: {
    reserved: true
  }
  sku: {
    name: 'B1'
  }
}

resource apiAppService 'Microsoft.Web/sites@2022-03-01' = {
  name: 'api-${resourceToken}'
  location: location
  tags: {
    'azd-service-name': 'api'
  }
  properties: {
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|6.0'
    }
    serverFarmId: appServicePlan.id
  }
}
