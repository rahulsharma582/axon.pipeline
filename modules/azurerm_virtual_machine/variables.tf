variable "virtual_machines" {
  description = "Map of Virtual Machine configurations"
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    subnet_id                       = string
    size                            = optional(string, "Standard_B1s")
    admin_username                  = optional(string, "azureuser")
    admin_password                  = optional(string)
    disable_password_authentication = optional(bool, false)
    ssh_public_key                  = optional(string)
    create_public_ip                = optional(bool, true)
    associate_nsg                   = optional(bool, false)
    network_security_group_id       = optional(string)
    os_disk_storage_account_type    = optional(string, "Standard_LRS")
    os_disk_caching                 = optional(string, "ReadWrite")
    os_disk_size_gb                 = optional(number, 30)
    image_publisher                 = optional(string, "Canonical")
    image_offer                     = optional(string, "0001-com-ubuntu-server-jammy")
    image_sku                       = optional(string, "22_04-lts")
    image_version                   = optional(string, "latest")
    tags                            = optional(map(string), {})
  }))
}
