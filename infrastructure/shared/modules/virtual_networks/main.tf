resource "azurerm_virtual_network" "developer_vnet" {
  name                = "vnet-developers"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.1/24"]
}

resource "azurerm_subnet" "infrastructure_test" {
  name                 = "subnet-developers-test"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.infrastructure_vnet.name
  address_prefixes     = ["10.0.1.1/24"]
}

resource "azurerm_subnet" "infrastructure_production" {
  name                 = "subnet-developers-production"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.infrastructure_vnet.name
  address_prefixes     = ["10.0.2.1/24"]
}

resource "azurerm_virtual_network" "infrastructure_vnet" {
  name                = "vnet-infrastructure"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.2/24"]

  subnet {
    name             = "subnet-infrastructure-test"
    address_prefixes = ["10.0.1.2/24"]
  }

  subnet {
    name             = "subnet-infrastructure-production"
    address_prefixes = ["10.0.2.2/24"]
  }
}