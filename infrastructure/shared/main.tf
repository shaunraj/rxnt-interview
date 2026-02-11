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


