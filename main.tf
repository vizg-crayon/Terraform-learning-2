# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"

  backend "azurerm" {
    resource_group_name  = "Vik-tf-rg"
    storage_account_name = "vikremotestorage"
    container_name       = "vikstrgcontainer"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "Vik-tf-rg"
  location = "southeastasia"
}

resource "azurerm_storage_account" "rg" {
  name                     = "vikremotestorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  ##allow_blob_public_access = true **No longer supported by Azure this syntax. This Access is automatically enabled.

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "rg" {
  name                  = "vikstrgcontainer"
  storage_account_name  = azurerm_storage_account.rg.name
  container_access_type = "blob"
}