terraform {
  backend "azurerm" {
    resource_group_name  = "TerraformRB"
    storage_account_name = "terraformrbstate1"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}