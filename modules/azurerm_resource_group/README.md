# Azure Resource Group Terraform Module

This Terraform module provisions one or more Azure Resource Groups dynamically using `for_each`.

## Usage

```hcl
module "resource_groups" {
  source = "../../modules/azurerm_resource_group"

  resource_groups = {
    rg1 = {
      name     = "rg-dev-eastus-001"
      location = "East US"
      tags = {
        Environment = "Dev"
        ManagedBy   = "Terraform"
      }
    }
  }
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `resource_groups` | Map of Resource Group configurations | `map(object)` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| `resource_groups` | Map of created Azure Resource Groups containing `id`, `name`, and `location` |
