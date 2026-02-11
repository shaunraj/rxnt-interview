data "azurerm_key_vault" "key_vault" {
  name                = local.shared_key_vault_name
  resource_group_name = local.shared_key_vault_resource_group_name
}

data "azurerm_key_vault_secret" "registry_name" {
  name         = "container-registry-name"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_certificate" "gateway_certificate" {
  name         = "${local.environment}-gateway-certificate"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "certificate_password" {
  name         = "${local.environment}-gateway-certificate-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_container_registry" "container_registry" {
  name                = data.azurerm_key_vault_secret.registry_name.value
  resource_group_name = local.container_registry_resource_group_name
}