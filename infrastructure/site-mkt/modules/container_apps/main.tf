resource "azurerm_container_app" "frontend" {
  name                         = "aca-marketing-frontend-${var.environment}"
  container_app_environment_id = var.marketing_site_container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    max_replicas = 10
    
    http_scale_rule {
      name                = "http-rule"
      concurrent_requests = 50
    }
    container {
      name   = "frontend"
      image  = "${data.azurerm_container_registry.container_registry.login_server}/${var.container_repository}/marketing-site:latest"
      cpu    = 1
      memory = "2Gi"
    }
  }
}

resource "azurerm_container_app" "backend" {
  name                         = "aca-marketing-api-${var.environment}"
  container_app_environment_id = var.marketing_site_container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  template {
    max_replicas = 10
    http_scale_rule {
      name                = "http-rule"
      concurrent_requests = 50
    }
    container {
      name   = "backend"
      image  = "${data.azurerm_container_registry.container_registry.login_server}/${var.container_repository}/marketing-api:latest"
      cpu    = 0.5
      memory = "1Gi"
      env {
        name  = "REDIS_CACHE_CONNECTION_STRING"
        value = var.redis_cache_connection_string
      }

      env {
        name  = "DB_CONNECTION_STRING"
        value = var.sql_db_connection_string
      }
    }
  }


}