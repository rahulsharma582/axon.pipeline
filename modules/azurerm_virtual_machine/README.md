# Azure Virtual Machine Terraform Module

This module provisions Azure Linux Virtual Machines with associated Network Interfaces, Public IPs (Standard SKU), and Network Security Group associations.

## Usage

```hcl
module "virtual_machines" {
  source = "../../modules/azurerm_virtual_machine"

  virtual_machines = {
    vm1 = {
      name                      = "vm-dev-eastus-001"
      location                  = "East US"
      resource_group_name       = "rg-dev-eastus-001"
      subnet_id                 = module.subnets.subnets["subnet1"].id
      size                      = "Standard_B1s"
      admin_username            = "azureuser"
      admin_password            = "P@ssw0rd12345!"
      create_public_ip          = true
      network_security_group_id = module.nsgs.nsgs["nsg1"].id
    }
  }
}
```

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| `virtual_machines` | Map of Virtual Machine configurations | `map(object)` | Yes |

## Outputs

| Name | Description |
|------|-------------|
| `virtual_machines` | Map of created Virtual Machines containing `id`, `name`, `private_ip_address`, and `public_ip_address` |
