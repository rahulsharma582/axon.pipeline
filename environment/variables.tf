variable "resource_groups" {
  description = "Map of Resource Groups to deploy"
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "vnets" {
  description = "Map of Virtual Networks to deploy"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    dns_servers         = optional(list(string))
    tags                = optional(map(string), {})
  }))
  default = {}
}

variable "subnets" {
  description = "Map of Subnets to deploy"
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
    service_endpoints    = optional(list(string))
  }))
  default = {}
}

variable "nsgs" {
  description = "Map of Network Security Groups and security rules to deploy"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string), {})
    rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string)
      destination_port_ranges    = optional(list(string))
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")
    })), [])
  }))
  default = {}
}

variable "virtual_machines" {
  description = "Map of Virtual Machines to deploy"
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    subnet_key                      = string
    nsg_key                         = optional(string)
    size                            = optional(string, "Standard_B1s")
    admin_username                  = optional(string, "azureuser")
    admin_password                  = optional(string)
    disable_password_authentication = optional(bool, false)
    ssh_public_key                  = optional(string)
    create_public_ip                = optional(bool, true)
    os_disk_storage_account_type    = optional(string, "Standard_LRS")
    os_disk_caching                 = optional(string, "ReadWrite")
    os_disk_size_gb                 = optional(number, 30)
    image_publisher                 = optional(string, "Canonical")
    image_offer                     = optional(string, "0001-com-ubuntu-server-jammy")
    image_sku                       = optional(string, "22_04-lts")
    image_version                   = optional(string, "latest")
    tags                            = optional(map(string), {})
  }))
  default = {}
}
