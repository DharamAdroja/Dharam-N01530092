resource "null_resource" "linuxvm" {
   provisioner "remote-exec" {
    inline = [
      "hostname"
    ]
  }
  count = var.nb_count
  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]
  connection {
    type = "ssh"
    user = var.admin_credentials["Username"]
    password = var.admin_credentials["Password"]
    host = element(azurerm_linux_virtual_machine.linux_vm[*].public_ip_address, count.index + 1)
  }
}