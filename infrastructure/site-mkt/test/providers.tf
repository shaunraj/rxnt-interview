terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.59.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "=3.7.0"
    }
  }
  backend "azurerm" {
    #resource_group_name and storage_account_name will need to be injected via the pipeline as environment variables
    container_name = "terraform_state"
    key            = "site.test.tfstate"
  }
}

provider "azurerm" {
  features {}
}

#We will need a tenant id. This will have to be injected via the pipeline via an environment variable
provider "azuread" {}