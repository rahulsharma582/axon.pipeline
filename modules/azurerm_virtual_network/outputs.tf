output "vnets" {
  description = "Map of created Virtual Networks indexed by key"
  value = {
    for k, vnet in azurerm_virtual_network.vnet : k => {
      id                  = vnet.id
      name                = vnet.name
      location            = vnet.location
      resource_group_name = vnet.resource_group_name
      address_space       = vnet.address_space
    }
  }
}
