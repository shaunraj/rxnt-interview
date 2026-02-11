variable "location" {
  type        = string
  description = "The Azure region where the Container App will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Container App will be created."
}


variable "container_repository" {
  type        = string
  description = "The name of the container repository in the Azure Container Registry where the marketing site images are stored."
}

variable "marketing_site_container_app_environment_id" {
  type        = string
  description = "The ID of the Container App Environment for the marketing site."
}

variable "redis_cache_connection_string" {
  type        = string
  description = "The connection string for the Redis Cache instance used by the marketing site."
}

variable "sql_db_connection_string" {
  type        = string
  description = "The connection string for the SQL Database used by the marketing site."
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the Container App environment is being created."
}

variable "registry_url" {
  type        = string
  description = "The login server URL of the Azure Container Registry where the marketing site images are stored."
}