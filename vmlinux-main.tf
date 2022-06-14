# Part-3 - A
resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.vm_name}-nic-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.rg
  tags                = local.common_tags

  ip_configuration {
    name                          = "${var.vm_name}-ipconfig1-${format("%1d", count.index + 1)}"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = var.allocation_method
    public_ip_address_id          = element( azurerm_public_ip.linux_pub_ip[*].id, count.index + 1 )
  }
}

# Part-3 - B
resource "azurerm_public_ip" "linux_pub_ip" {
  count               = var.nb_count
  name                = "${var.vm_name}-pip-${format("%1d", count.index + 1)}"
  resource_group_name = var.rg
  location            = var.location
  allocation_method   = var.allocation_method
  domain_name_label   = var.pubip_dns_label
  tags                = local.common_tags
}

# Part-3 - C
resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                           = var.nb_count
  name                            = "${var.vm_name}-${format("%1d", count.index + 1)}" 
  location                        = var.location
  resource_group_name             = var.rg
  size                            = var.vm_size
  admin_username                  = var.admin_credentials["Username"]
  admin_password                  = var.admin_credentials["Password"]
  network_interface_ids           = [element(azurerm_network_interface.linux_nic[*].id, count.index + 1)]
  computer_name                   = "${var.vm_name}-admin-${format("%1d", count.index + 1)}"
  disable_password_authentication = "false"
  tags = local.common_tags

  source_image_reference {
    publisher = var.los_image_info["Publisher"]
    offer     = var.los_image_info["Offer"]
    sku       = var.los_image_info["Sku"]
    version   = var.los_image_info["Version"]
  }

  os_disk {
    name                  = "${var.los_disk_attr["disk_name"]}-${format("%1d", count.index + 1)}"
    caching               = var.los_disk_attr["disk_caching"]
    storage_account_type  = var.los_disk_attr["storage_account_type"]
  }
}

resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_avs
  location                     = var.location
  resource_group_name          = var.rg
  platform_fault_domain_count  = "2"
  platform_update_domain_count = "5"
}