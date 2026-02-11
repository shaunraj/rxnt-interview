resource "azurerm_redis_cache" "redis_cache" {
  name                 = "site-mkt-redis-cache-${var.environment}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  capacity             = 1
  family               = "C"
  sku_name             = "Standard"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
}