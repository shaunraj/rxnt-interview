


module "resource_groups" {
  source      = "../modules/resource_groups"
  location    = local.location
  environment = local.environment
}

module "container_app_environment" {
  source              = "../modules/container_app_environments"
  location            = local.location
  resource_group_name = module.resource_groups.site_mkt_group_name
  environment         = local.environment
}

module "redis_cache" {
  source              = "../modules/redis"
  location            = local.location
  resource_group_name = module.resource_groups.site_mkt_group_name
  environment         = local.environment
}

module "sql_server" {
  source              = "../modules/sql-server"
  location            = local.location
  resource_group_name = module.resource_groups.site_mkt_group_name
  environment         = local.environment
}

module "container_apps" {
  source                                      = "../modules/container_apps"
  location                                    = local.location
  resource_group_name                         = module.resource_groups.site_mkt_group_name
  shared_key_vault_id                         = data.azurerm_key_vault.key_vault.id
  container_registry_resource_group_name      = local.container_registry_resource_group_name
  container_repository                        = data.azurerm_container_registry.container_registry.id
  marketing_site_container_app_environment_id = module.container_app_environment.marketing_site_container_app_environment_id
  redis_cache_connection_string               = module.redis_cache.redis_cache_connection_string
  sql_db_connection_string                    = module.sql_server.sql_server_connection_string
  environment                                 = local.environment
}

module "application_gateway" {
  source                      = "../modules/application_gateway"
  location                    = local.location
  resource_group_name         = module.resource_groups.site_mkt_group_name
  pfx_certificate_data_base64 = azurerm_key_vault_certificate.self-signed-cert.certificate_data
  cert_password               = azurerm_key_vault_certificate.self-signed-cert.password
  environment                 = local.environment
}

module "key_vault" {
  source              = "../modules/key_vaults"
  location            = local.location
  resource_group_name = local.shared_key_vault_resource_group_name
  environment         = local.environment
}

resource "azurerm_key_vault_certificate" "self-signed-cert" {
  name         = "generated-cert"
  key_vault_id = module.key_vault.key_vault_id

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
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject_alternative_names {
        dns_names = ["internal.contoso.com", "domain.hello.world"]
      }

      subject            = "CN=hello-world"
      validity_in_months = 12
    }
  }
}
