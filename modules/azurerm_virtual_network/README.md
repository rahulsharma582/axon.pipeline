# Azure Virtual Network Terraform Module

This module manages Azure Virtual Networks dynamically across resource groups.

## Usage

```hcl
module "vnets" {
  source = "../../modules/azurerm_virtual_network"

  vnets = {
    vnet1 = {
      name                = "vnet-dev-eastus-001"
      location            = "East US"
      resource_group_name = "rg-dev-eastus-001"
      address_space       = ["10.0.0.0/16"]
    }
  }
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `vnets` | Map of Virtual Network configurations | `map(object)` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| `vnets` | Map of created Virtual Networks containing `id`, `name`, `location`, `resource_group_name`, and `address_space` |
