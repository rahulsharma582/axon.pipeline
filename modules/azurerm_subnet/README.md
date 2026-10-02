# Azure Subnet Terraform Module

This module manages Azure Subnets within specified Virtual Networks.

## Usage

```hcl
module "subnets" {
  source = "../../modules/azurerm_subnet"

  subnets = {
    subnet1 = {
      name                 = "snet-web-eastus-001"
      resource_group_name  = "rg-dev-eastus-001"
      virtual_network_name = "vnet-dev-eastus-001"
      address_prefixes     = ["10.0.1.0/24"]
    }
  }
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `subnets` | Map of Subnet configurations | `map(object)` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| `subnets` | Map of created Subnets containing `id`, `name`, `resource_group_name`, `virtual_network_name`, and `address_prefixes` |
