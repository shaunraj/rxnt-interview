resource "azurerm_resource_group" "shared_resource_group" {
  name     = "rg-shared-resources"
  location = var.location
}