variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Application Gateway will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the Application Gateway will be created."
}

variable "pfx_certificate_data_base64" {
  type        = string
  description = "The base64-encoded PFX certificate data for the Application Gateway SSL certificate."
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the Container App environment is being created."
}