data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                       = "kv-rxnt"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 30

  tags = {
    project = "shared-resources"
  }
}

resource "azurerm_private_endpoint" "pep" {
  name                = "pep-acrrxnt"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "pep-connection-acr"
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    is_manual_connection           = false
    subresource_names              = ["keyvault"]
  }
}