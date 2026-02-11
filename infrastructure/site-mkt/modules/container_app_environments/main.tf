resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "law-marketing-container-apps-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "marketing_container_app_env" {
  name                       = "marketing-container-app-env-${var.environment}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  workload_profile {
    name                  = "marketing-container-app-env-wp"
    workload_profile_type = "Consumption"
  }

  tags = {
    project = "site-mkt"
  }
}
