param name string
param location string = resourceGroup().location
param tags object = {}
// param applicationInsightName string = ''

// param alwaysOn bool = true
// param ftpsState string = 'FtpsOnly'
param linuxFxVersion string
param appServicePlanId string

resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
    }
    serverFarmId: appServicePlanId
  }
}

// resource name_resource 'Microsoft.Web/sites@2022-03-01' = {
//   name: name
//   location: location
//   tags: tags
//   properties: {
//     siteConfig: {
//       appSettings: [
//         {
//           name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
//           value: applicationInsights.properties.InstrumentationKey
//         }
//         {
//           name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
//           value: applicationInsights.properties.ConnectionString
//         }
//         {
//           name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
//           value: '~3'
//         }
//         {
//           name: 'XDT_MicrosoftApplicationInsights_Mode'
//           value: 'Recommended'
//         }
//       ]
//       linuxFxVersion: linuxFxVersion
//       alwaysOn: alwaysOn
//       ftpsState: ftpsState
//     }
//     serverFarmId: appServicePlanId
//     clientAffinityEnabled: false
//     virtualNetworkSubnetId: null
//     httpsOnly: true
//     publicNetworkAccess: 'Enabled'
//   }
//   dependsOn: []
// }

// resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
//   name: applicationInsightName
// }

