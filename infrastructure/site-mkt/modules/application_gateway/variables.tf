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

variable "cert_password" {
  type        = string
  description = "The password for the PFX certificate used by the Application Gateway."
}