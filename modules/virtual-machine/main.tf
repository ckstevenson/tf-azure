provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = var.vm_rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.subnet_rg_name
}

resource "azurerm_network_interface" "if" {
  name                = var.if_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

#resource "azurerm_network_security_group" "nsg" {
#  name                = "cameron-sg"
#  resource_group_name = data.azurerm_resource_group.rg.name
#  location            = data.azurerm_resource_group.rg.location
#
#  security_rule {
#    name                       = "SSH"
#    priority                   = 100
#    direction                  = "Inbound"
#    access                     = "Allow"
#    protocol                   = "Tcp"
#    source_port_range          = "*"
#    destination_port_range     = "22"
#    source_address_prefix      = "*"
#    destination_address_prefix = "*"
#  }
#
#  tags = {
#    name = var.vm_name
#    CreatedBy = "Cameron" 
#  }
#}
#
#resource "azurerm_network_interface_security_group_association" "nsg_association" {
#  network_interface_id          = azurerm_network_interface.if.id
#  network_security_group_id     = azurerm_network_security_group.nsg.id
#}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.os_type == "linux" ? 1 : 0
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_B2s"
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.if.id,
  ]

  tags = var.vm_tags

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.vm_sri.publisher
    offer     = var.vm_sri.offer
    sku       = var.vm_sri.sku
    version   = var.vm_sri.version
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = var.os_type == "windows" ? 1 : 0
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_B2s"
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [
    azurerm_network_interface.if.id,
  ]

  tags = var.vm_tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_sri.publisher
    offer     = var.vm_sri.offer
    sku       = var.vm_sri.sku
    version   = var.vm_sri.version
  }
}

output "resource_group_id" {
  value = data.azurerm_resource_group.rg.id
}

output "resource_network_interface" {
  value = azurerm_network_interface.if.ip_configuration
}

