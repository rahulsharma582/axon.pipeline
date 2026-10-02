terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Uncomment and configure remote state backend for production:
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "sttfstate001"
  #   container_name       = "tfstate"
  #   key                  = "vm-infra.dev.tfstate"
  # }
}

provider "azurerm" {
  features {}
}
