variable "location" {
  type        = string
  description = "The Azure region where the Container App will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Container App will be created."
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the Container App environment is being created."
}