output "vm_private_ip" {
  value = azurerm_network_interface.linux_nic[*].private_ip_address
}
output "vm_public_ip" {
  value = azurerm_public_ip.linux_pub_ip[*].ip_address
}
output "vm_vnet_name" {
  value = azurerm_virtual_network.v-net.name
}
output "vm_address_space" {
  value = azurerm_virtual_network.v-net.address_space
}
output "vm_subnet1_name" {
  value = azurerm_subnet.subnet1.name
}
output "vm_subnet2_name" {
    value = azurerm_subnet.subnet2.name
}
output "vm_subnet1_address_space" {
  value = azurerm_subnet.subnet1.address_prefixes
}
output "vm_subnet2_address_space" {
  value = azurerm_subnet.subnet2.address_prefixes
}
output "vm_linux_availability_sets" {
  value = azurerm_availability_set.linux_avs.name
}
output "vm_linux_hostnames" {
  value =azurerm_linux_virtual_machine.linux_vm[*].name
}
output "vm_nics" {
  value = azurerm_network_interface.linux_nic[*].name
}
output "vm_pips" {
  value = azurerm_public_ip.linux_pub_ip[*].name
}