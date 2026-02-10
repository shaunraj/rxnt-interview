data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                        = "kv-rxnt"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days = 30

  tags = {
    project = "shared-resources"
  }
}