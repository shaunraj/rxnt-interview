variable "location" {
  type        = string
  description = "The location where the Redis Cache will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Redis Cache will be created."
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the Container App environment is being created."
}