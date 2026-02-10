
resource "azurerm_resource_group" "shared_resource_group" {
  name     = "rg-rxnt-shared-resources"
  location = var.location
}