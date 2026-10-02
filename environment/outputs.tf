output "resource_group_details" {
  description = "Deployed resource group details"
  value       = module.resource_groups.resource_groups
}

output "vnet_details" {
  description = "Deployed virtual network details"
  value       = module.vnets.vnets
}

output "subnet_details" {
  description = "Deployed subnet details"
  value       = module.subnets.subnets
}

output "nsg_details" {
  description = "Deployed NSG details"
  value       = module.nsgs.nsgs
}

output "virtual_machine_details" {
  description = "Deployed virtual machine details including public & private IPs"
  value       = module.virtual_machines.virtual_machines
  sensitive   = false
}

output "ssh_connection_commands" {
  description = "SSH connection helper commands for deployed VMs"
  value = {
    for k, vm in module.virtual_machines.virtual_machines : k => (
      vm.public_ip_address != null ? "ssh ${lookup(var.virtual_machines[k], "admin_username", "azureuser")}@${vm.public_ip_address}" : "No Public IP assigned (Internal IP: ${vm.private_ip_address})"
    )
  }
}
