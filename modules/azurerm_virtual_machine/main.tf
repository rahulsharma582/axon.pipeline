resource "azurerm_public_ip" "pip" {
  for_each = {
    for k, v in var.virtual_machines : k => v
    if lookup(v, "create_public_ip", true)
  }

  name                = "${each.value.name}-pip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = lookup(each.value, "tags", {})
}

resource "azurerm_network_interface" "nic" {
  for_each = var.virtual_machines

  name                = "${each.value.name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = lookup(each.value, "tags", {})

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = lookup(each.value, "create_public_ip", true) ? azurerm_public_ip.pip[each.key].id : null
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  for_each = {
    for k, v in var.virtual_machines : k => v
    if lookup(v, "network_security_group_id", null) != null
  }

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = each.value.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.virtual_machines

  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  size                            = lookup(each.value, "size", "Standard_B1s")
  admin_username                  = lookup(each.value, "admin_username", "azureuser")
  admin_password                  = lookup(each.value, "admin_password", null)
  disable_password_authentication = lookup(each.value, "disable_password_authentication", false)

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "ssh_public_key", null) != null ? [each.value.ssh_public_key] : []
    content {
      username   = lookup(each.value, "admin_username", "azureuser")
      public_key = admin_ssh_key.value
    }
  }

  os_disk {
    caching              = lookup(each.value, "os_disk_caching", "ReadWrite")
    storage_account_type = lookup(each.value, "os_disk_storage_account_type", "Standard_LRS")
    disk_size_gb         = lookup(each.value, "os_disk_size_gb", 30)
  }

  source_image_reference {
    publisher = lookup(each.value, "image_publisher", "Canonical")
    offer     = lookup(each.value, "image_offer", "0001-com-ubuntu-server-jammy")
    sku       = lookup(each.value, "image_sku", "22_04-lts")
    version   = lookup(each.value, "image_version", "latest")
  }

  tags = lookup(each.value, "tags", {})
}
