resource "azurerm_key_vault" "marketing_site_key_vault" {
  name                       = "kv-site-mkt-${var.environment}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = true
  soft_delete_retention_days = 30

  tags = {
    "environment" = var.environment
    "project"     = "site-mkt"
  }
}

resource "azurerm_key_vault_certificate" "self_signed_cert" {
  name         = "generated-cert"
  key_vault_id = azurerm_key_vault.marketing_site_key_vault.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 365
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = "CN=test"
      validity_in_months = 12
    }
  }
}

resource "azurerm_role_assignment" "backend_key_vault_access" {
  principal_id         = var.backend_managed_identity
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.marketing_site_key_vault.id
}