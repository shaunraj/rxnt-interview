locals {
  shared_key_vault_name                  = "kv-rxnt"
  shared_key_vault_resource_group_name   = "rg-shared-resources"
  container_registry_resource_group_name = "rg-shared-resources"
  location                               = "westus2"
  environment                            = "test"
  registry_repository                    = "internal"
}