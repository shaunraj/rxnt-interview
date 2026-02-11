module "resource_groups" {
  source      = "./modules/resource_groups"
  location    = local.location
  environment = var.environment
}

module "container_app_environment" {
  source              = "./modules/container_app_environments"
  location            = local.location
  resource_group_name = module.resource_groups.site_mkt_group_name
  environment         = var.environment
}

module "redis_cache" {
  source              = "./modules/redis"
  location            = local.location
  resource_group_name = module.resource_groups.site_mkt_group_name
  environment         = var.environment
}

module "sql_server" {
  source              = "./modules/sql-server"
  location            = local.location
  resource_group_name = module.resource_groups.site_mkt_group_name
  environment         = var.environment
}

module "container_apps" {
  source                                      = "./modules/container_apps"
  location                                    = local.location
  resource_group_name                         = module.resource_groups.site_mkt_group_name
  container_repository                        = var.registry_repository
  marketing_site_container_app_environment_id = module.container_app_environment.marketing_site_container_app_environment_id
  redis_cache_connection_string               = module.redis_cache.redis_cache_connection_string
  sql_db_connection_string                    = module.sql_server.sql_server_connection_string
  environment                                 = var.environment
  registry_url                                = data.azurerm_container_registry.container_registry.login_server
}

module "key_vault" {
  source                   = "./modules/key_vaults"
  location                 = local.location
  resource_group_name      = local.shared_key_vault_resource_group_name
  environment              = var.environment
  backend_managed_identity = module.container_apps.backend_managed_identity
}

module "application_gateway" {
  source                      = "./modules/application_gateway"
  location                    = local.location
  resource_group_name         = module.resource_groups.site_mkt_group_name
  pfx_certificate_data_base64 = module.key_vault.self_signed_certificate_data
  environment                 = var.environment
}