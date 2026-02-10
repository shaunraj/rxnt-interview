output "registry_url" {
    value = azurerm_container_registry.container_registry.login_server
    description = "The URL of the container registry."
}

output "registry_name" {
    value = azurerm_container_registry.container_registry.name
    description = "The name of the container registry."
}