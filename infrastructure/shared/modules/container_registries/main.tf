resource "azurerm_container_registry" "container_registry" {
  name                          = "acrrxnt"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = true
  public_network_access_enabled = false

  tags = {
    project = "shared-resources"
  }

}

resource "azurerm_role_assignment" "registry_role_definitions" {
  for_each             = { for role in local.role_assignments : role.ad_group_name => role }
  role_definition_name = each.value.role_definition_name
  principal_id         = data.azuread_group.azure_ad_groups[each.value.ad_group_name].object_id
  scope                = azurerm_container_registry.container_registry.id
}