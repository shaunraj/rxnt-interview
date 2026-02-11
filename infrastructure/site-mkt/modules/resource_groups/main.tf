resource "azurerm_resource_group" "market_resource_group" {
  name     = "rg-site-mkt"
  location = var.location
}