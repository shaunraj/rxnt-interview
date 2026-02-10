variable "location" {
  type        = string
  description = "The Azure region where the Container App will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Container App will be created."
}

variable "shared_key_vault_id" {
  type        = string
  description = "The ID of the global Key Vault for all teams."
}

variable "container_repository" {
  type        = string
  description = "The name of the container repository in the Azure Container Registry where the marketing site images are stored."
}

variable "container_registry_resource_group_name" {
  type        = string
  description = "The name of the resource group where the Azure Container Registry is located."
}

variable "marketing_site_container_app_environment_id" {
  type        = string
  description = "The ID of the Container App Environment for the marketing site."
}