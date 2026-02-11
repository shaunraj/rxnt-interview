data "azurerm_container_registry" "container_registry" {
  name                = "acrrxnt"
  resource_group_name = "rg-shared-resources"
}