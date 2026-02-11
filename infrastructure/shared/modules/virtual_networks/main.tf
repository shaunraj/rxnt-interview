resource "azurerm_virtual_network" "developer_vnet" {
  name                = "vnet-developers"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.1/24"]
}