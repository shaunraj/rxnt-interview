resource "azurerm_redis_cache" "redis_cache" {
  name                 = "site-mkt-redis-cache"
  location             = var.location
  resource_group_name  = var.resource_group_name
  capacity             = 1
  family               = "C"
  sku_name             = "Standard"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"

  # This is to enable backup. We haven't spun up a storage container for Redis cache yet, but this is the configuration we will need when we do.
  #   redis_configuration {
  #     rdb_backup_enabled            = true
  #     rdb_backup_frequency          = 60
  #     rdb_backup_max_snapshot_count = 1
  #     rdb_storage_connection_string = var.backup_blob_storage_connection_string
  #   }

}