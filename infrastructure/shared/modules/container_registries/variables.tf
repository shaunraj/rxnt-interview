variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
}

variable "sku" {
  type        = string
  description = "The SKU of the registry we would like to spin up (e.g., Basic, Standard, Premium)."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the container registry will be created."
}

variable "subnet_id" {
  type        = string
  description = "Id of the subnet where to spin up the container registry"
}