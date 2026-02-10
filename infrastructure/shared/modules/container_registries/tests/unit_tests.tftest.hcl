mock_provider "azurerm" {
  alias = "fake"
  mock_data "azurerm_client_config" {
    defaults = {
      tenant_id = "11111111-1111-1111-1111-111111111111"
    }
  }
}

mock_provider "azuread" {
  alias = "fake"
  mock_data "azuread_group" {
    defaults = {
      object_id = "11111111-1111-1111-1111-111111111111"
    }
  }
}

run "permissions_are_added_for_all_role_assignments" {
  command = plan

  providers = {
    azurerm = azurerm.fake
    azuread = azuread.fake
  }

  variables {
    location            = "westus2"
    resource_group_name = "rg-rxnt"
    sku                 = "Basic"
  }

  assert {
    condition     = length(azurerm_role_assignment.registry_role_definitions) == 3
    error_message = "Number of roles do not match"
  }

  assert {
    condition     = azurerm_role_assignment.registry_role_definitions["Container Registry Writers"].role_definition_name == "Container Registry Repository Writer"
    error_message = "Role definition name for Container Registry Writers does not match"
  }
}