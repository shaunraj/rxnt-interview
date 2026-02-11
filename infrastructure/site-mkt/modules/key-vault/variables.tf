variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the Key Vault is being created."
}

variable "location" {
  type        = string
  description = "The Azure region where the Key Vault will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Key Vault will be created."
}

variable "backend_managed_identity" {
  type        = string
  description = "The principal ID of the backend container app's managed identity. This will be used to grant the backend access to the Key Vault."
}