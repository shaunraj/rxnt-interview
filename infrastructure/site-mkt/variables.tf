variable "environment" {
  type        = string
  description = "The environment (e.g., dev, test, prod) for which the Container App environment is being created."
}

variable "registry_repository" {
  type        = string
  description = "The name of the container registry repository where the marketing site images will be stored."
}