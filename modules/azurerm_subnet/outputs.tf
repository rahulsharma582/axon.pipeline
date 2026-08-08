output "subnets" {
  description = "Map of created Subnets indexed by key"
  value = {
    for k, subnet in azurerm_subnet.subnet : k => {
      id                   = subnet.id
      name                 = subnet.name
      resource_group_name  = subnet.resource_group_name
      virtual_network_name = subnet.virtual_network_name
      address_prefixes     = subnet.address_prefixes
    }
  }
}
