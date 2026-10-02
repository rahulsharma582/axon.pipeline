output "resource_groups" {
  description = "Map of created Azure Resource Groups indexed by key"
  value = {
    for k, rg in azurerm_resource_group.rg : k => {
      id       = rg.id
      name     = rg.name
      location = rg.location
    }
  }
}
