variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the SQL Server will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the SQL Server will be created."
}