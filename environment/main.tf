module "resource_groups" {
  source = "../modules/azurerm_resource_group"

  resource_groups = var.resource_groups
}

module "vnets" {
  source     = "../modules/azurerm_virtual_network"
  depends_on = [module.resource_groups]

  vnets = var.vnets
}

module "subnets" {
  source     = "../modules/azurerm_subnet"
  depends_on = [module.vnets]

  subnets = var.subnets
}

module "nsgs" {
  source     = "../modules/azurerm_network_security_group"
  depends_on = [module.resource_groups]

  nsgs = var.nsgs
}

module "virtual_machines" {
  source     = "../modules/azurerm_virtual_machine"
  depends_on = [module.subnets, module.nsgs]

  virtual_machines = {
    for k, vm in var.virtual_machines : k => {
      name                            = vm.name
      location                        = vm.location
      resource_group_name             = vm.resource_group_name
      subnet_id                       = module.subnets.subnets[vm.subnet_key].id
      network_security_group_id       = vm.nsg_key != null ? module.nsgs.nsgs[vm.nsg_key].id : null
      size                            = vm.size
      admin_username                  = vm.admin_username
      admin_password                  = vm.admin_password
      disable_password_authentication = vm.disable_password_authentication
      ssh_public_key                  = vm.ssh_public_key
      create_public_ip                = vm.create_public_ip
      os_disk_storage_account_type    = vm.os_disk_storage_account_type
      os_disk_caching                 = vm.os_disk_caching
      os_disk_size_gb                 = vm.os_disk_size_gb
      image_publisher                 = vm.image_publisher
      image_offer                     = vm.image_offer
      image_sku                       = vm.image_sku
      image_version                   = vm.image_version
      tags                            = vm.tags
    }
  }
}
