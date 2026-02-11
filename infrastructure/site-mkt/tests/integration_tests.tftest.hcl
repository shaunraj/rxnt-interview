mock_provider "azurerm" {
  alias = "fake"
  mock_data "azurerm_client_config" {
    defaults = {
      tenant_id = "11111111-1111-1111-1111-111111111111"
    }
  }

  mock_data "azurerm_key_vault" {
   defaults = {
    id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-shared-resources/providers/Microsoft.KeyVault/vaults/kv-rxnt"  
   }
  }

  mock_data "azurerm_container_registry" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-shared-resources/providers/Microsoft.ContainerRegistry/registries/cr-rxnt"
    }
  }

  mock_data "azurerm_key_vault_secret" {
    defaults = {
      value = "testSecret"
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

run "modules_are_hooked_up_correctly_and_pass_validation" {
  providers = {
    azurerm = azurerm.fake
    azuread = azuread.fake
  }

  command = plan

}