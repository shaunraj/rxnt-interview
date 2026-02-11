output "infrastructure_vnet_id" {
  value = azurerm_virtual_network.infrastructure_vnet.id
}

output "production_vnet_id" {
  value = azurerm_subnet.infrastructure_production.id
}