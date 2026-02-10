variable "container_registry_url" {
  type = string
  description = "The URL of the container registry that we want to store as a secret in Key Vault."
}

variable "container_registry_name" {
  type = string
  description = "The name of the container registry that we want to store as a secret in Key Vault."
}

variable "shared_key_vault_id" {
  type = string
  description = "The ID of the global Key Vault for all teams."
}
