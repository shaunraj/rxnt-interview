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

run "modules_are_hooked_up_correctly_and_pass_validation" {
  providers = {
    azurerm = azurerm.fake
    azuread = azuread.fake
  }

  command = plan

}