variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Key Vault will be created."
}

variable "subnet_id" {
  type        = string
  description = "The id of the subnet where the resource will be created"
}