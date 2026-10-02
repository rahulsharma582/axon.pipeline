output "virtual_machines" {
  description = "Map of created Virtual Machines indexed by key"
  value = {
    for k, vm in azurerm_linux_virtual_machine.vm : k => {
      id                  = vm.id
      name                = vm.name
      location            = vm.location
      resource_group_name = vm.resource_group_name
      private_ip_address  = azurerm_network_interface.nic[k].private_ip_address
      public_ip_address   = lookup(azurerm_public_ip.pip, k, null) != null ? azurerm_public_ip.pip[k].ip_address : null
    }
  }
}
