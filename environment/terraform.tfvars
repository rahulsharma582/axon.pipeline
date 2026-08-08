resource_groups = {
  rg_dev = {
    name     = "rg-dev-eastus-001"
    location = "East US"
    tags = {
      Environment = "Dev"
      ManagedBy   = "Terraform"
      Project     = "InfrastructureVM"
    }
  }
}

vnets = {
  vnet_dev = {
    name                = "vnet-dev-eastus-001"
    location            = "East US"
    resource_group_name = "rg-dev-eastus-001"
    address_space       = ["10.0.0.0/16"]
    tags = {
      Environment = "Dev"
      ManagedBy   = "Terraform"
    }
  }
}

subnets = {
  subnet_web = {
    name                 = "snet-web-eastus-001"
    resource_group_name  = "rg-dev-eastus-001"
    virtual_network_name = "vnet-dev-eastus-001"
    address_prefixes     = ["10.0.1.0/24"]
  }
}

nsgs = {
  nsg_web = {
    name                = "nsg-web-eastus-001"
    location            = "East US"
    resource_group_name = "rg-dev-eastus-001"
    tags = {
      Environment = "Dev"
      ManagedBy   = "Terraform"
    }
    rules = [
      {
        name                   = "AllowSSH"
        priority               = 100
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        destination_port_range = "22"
      },
      {
        name                   = "AllowHTTP"
        priority               = 200
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        destination_port_range = "80"
      },
      {
        name                   = "AllowHTTPS"
        priority               = 300
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        destination_port_range = "443"
      }
    ]
  }
}

virtual_machines = {
  vm_dev_01 = {
    name                            = "vm-dev-web-01"
    location                        = "East US"
    resource_group_name             = "rg-dev-eastus-001"
    subnet_key                      = "subnet_web"
    nsg_key                         = "nsg_web"
    size                            = "Standard_B1s"
    admin_username                  = "azureuser"
    admin_password                  = "P@ssw0rd12345!"
    disable_password_authentication = false
    create_public_ip                = true
    os_disk_storage_account_type    = "Standard_LRS"
    tags = {
      Environment = "Dev"
      Role        = "WebServer"
      ManagedBy   = "Terraform"
    }
  }
}
