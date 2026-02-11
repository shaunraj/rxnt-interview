data "azuread_group" "azure_ad_groups" {
  for_each     = { for role in local.role_assignments : role.ad_group_name => role }
  display_name = each.value.ad_group_name
}



resource "azurerm_container_registry" "container_registry" {
  name                = "acrrxnt"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
  public_network_access_enabled = false

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
    name                              = "pep-connection-acr"
    private_connection_resource_id    = azurerm_container_registry.container_registry.id
    is_manual_connection              = false
    subresource_names                 = ["registry"]
  }
}


resource "azurerm_role_assignment" "registry_role_definitions" {
  for_each             = { for role in local.role_assignments : role.ad_group_name => role }
  role_definition_name = each.value.role_definition_name
  principal_id         = data.azuread_group.azure_ad_groups[each.value.ad_group_name].object_id
  scope                = azurerm_container_registry.container_registry.id
}