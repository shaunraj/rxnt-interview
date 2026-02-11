variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
}

variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the Container App environment is being created."
}