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
    key            = "site.test.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}