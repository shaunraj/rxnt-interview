data "azurerm_key_vault" "key_vault" {
  name                = var.shared_key_vault_name
  resource_group_name = var.resource_group_name
}