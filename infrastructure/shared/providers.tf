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
    key            = "shared.tfstate"
  }
}

provider "azurerm" {
  features {}
}

#We will need a tenant id. This will have to be injected via the pipeline via an environment variable
provider "azuread" {}