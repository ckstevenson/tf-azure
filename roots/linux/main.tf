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
