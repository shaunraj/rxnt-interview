output "key_vault_id" {
  value = azurerm_key_vault.marketing_site_key_vault.id
}

output "self_signed_certificate_data" {
  value = azurerm_key_vault_certificate.self_signed_cert.certificate_data
}