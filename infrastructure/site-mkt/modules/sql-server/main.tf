data "azuread_group" "marketing_database_admins" {
  display_name = "Marketing Database Admins"
}

resource "azurerm_mssql_server" "marketing_sql_server" {
  name                = "sql-rxnt-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  azuread_administrator {
    azuread_authentication_only = true
    login_username              = data.azuread_group.marketing_database_admins.display_name
    object_id                   = data.azuread_group.marketing_database_admins.object_id
  }

  version = "12.0"
}

resource "azurerm_mssql_elasticpool" "elastic_pool" {
  name                = "epool-marketing-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_mssql_server.marketing_sql_server.name
  license_type        = "LicenseIncluded"
  max_size_gb         = 4

  sku {
    name     = "BasicPool"
    tier     = "Basic"
    family   = "Gen4"
    capacity = 4
  }

  per_database_settings {
    min_capacity = 0.25
    max_capacity = 4
  }
}