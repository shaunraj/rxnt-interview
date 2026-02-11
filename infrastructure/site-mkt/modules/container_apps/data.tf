data "azurerm_key_vault_secret" "key_vault_secrets" {
  name         = "container-registry-name"
  key_vault_id = var.shared_key_vault_id
}

data "azurerm_container_registry" "container_registry" {
  name                = data.azurerm_key_vault_secret.key_vault_secrets.value
  resource_group_name = var.container_registry_resource_group_name
}