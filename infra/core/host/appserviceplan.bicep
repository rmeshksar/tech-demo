param name string
param location string = resourceGroup().location
param tags object = {}

param kind string = ''
param reserved bool = true
param sku object

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  kind: kind
  tags: tags
  properties: {
    reserved: reserved
  }
  sku: sku
}

output id string = appServicePlan.id
