output "nsgs" {
  description = "Map of created Network Security Groups indexed by key"
  value = {
    for k, nsg in azurerm_network_security_group.nsg : k => {
      id                  = nsg.id
      name                = nsg.name
      location            = nsg.location
      resource_group_name = nsg.resource_group_name
    }
  }
}
