resource "azurerm_key_vault_secret" "container_registry_url" {
  name = "container-registry-url"
  value = var.container_registry_url
  key_vault_id = var.shared_key_vault_id
}

resource "azurerm_key_vault_secret" "container_registry_name" {
  name = "container-registry-name"
  value = var.container_registry_url
  key_vault_id = var.shared_key_vault_id
}