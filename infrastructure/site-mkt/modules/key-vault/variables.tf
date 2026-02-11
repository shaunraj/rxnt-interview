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