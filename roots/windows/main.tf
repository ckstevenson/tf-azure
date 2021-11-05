locals {
  vm_name = "cameron-test"
}

module "azurem_linux_bastion_test" {
  source         = "../../modules/virtual-machine/"
  vm_name        = "${local.vm_name}-l"
  os_type        = "linux"
  username       = "cameron"
  password       = "test1235"# Note stored in plain-text. Don't use!
  if_name        = "cameron-bastion-if"
  public_ip_name = "cameron-bastion-ip"
  subnet_name    = ""
  vnet_name      = ""
  vm_rg_name     = ""
  subnet_rg_name = ""
  vm_tags = {
    name       = local.vm_name
    CreatedBy  = "Cameron"
    CreatedFor = ""
  }
  vm_sri = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

module "azurem_windows_bastion_test" {
  source         = "../../modules/virtual-machine/"
  vm_name        = "${local.vm_name}-w"
  os_type        = "windows"
  username       = "cameron"
  password       = "!@#*tst35" # Note stored in plain-text. Don't use!
  if_name        = "cameron-bastion-if-windows"
  public_ip_name = "cameron-bastion-ip-windows"
  subnet_name    = ""
  vnet_name      = ""
  vm_rg_name     = ""
  subnet_rg_name = ""
  vm_tags = {
    name       = local.vm_name
    CreatedBy  = "Cameron"
    CreatedFor = ""
  }
  vm_sri = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
