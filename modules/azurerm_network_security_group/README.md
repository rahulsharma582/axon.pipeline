# Azure Network Security Group (NSG) Terraform Module

This module provisions Azure Network Security Groups with dynamic security rules.

## Usage

```hcl
module "nsgs" {
  source = "../../modules/azurerm_network_security_group"

  nsgs = {
    nsg1 = {
      name                = "nsg-web-eastus-001"
      location            = "East US"
      resource_group_name = "rg-dev-eastus-001"
      rules = [
        {
          name                   = "AllowSSH"
          priority               = 100
          direction              = "Inbound"
          access                 = "Allow"
          protocol               = "Tcp"
          destination_port_range = "22"
        }
      ]
    }
  }
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `nsgs` | Map of Network Security Group configurations | `map(object)` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| `nsgs` | Map of created NSGs containing `id`, `name`, `location`, and `resource_group_name` |
