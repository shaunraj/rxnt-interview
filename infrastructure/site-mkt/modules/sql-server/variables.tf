variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the SQL Server will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the SQL Server will be created."
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the SQL Server is being created."
}