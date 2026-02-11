module "resource_groups" {
  source   = "./modules/resource_groups"
  location = local.location
}

module "container_registries" {
  source              = "./modules/container_registries"
  location            = local.location
  sku                 = local.sku
  resource_group_name = module.resource_groups.shared_resource_group_name
}

module "key_vaults" {
  source              = "./modules/key_vaults"
  location            = local.location
  resource_group_name = module.resource_groups.shared_resource_group_name
}

module "key_vault_secrets" {
  source                  = "./modules/key_vault_secrets"
  container_registry_url  = module.container_registries.registry_url
  shared_key_vault_id     = module.key_vaults.key_vault_id
  container_registry_name = module.container_registries.registry_name
}

