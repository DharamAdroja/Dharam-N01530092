
resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
  #depends_on = [azurerm_linux_virtual_machine.linux_vm]
}

resource "azurerm_virtual_network" "v-net" {
  name                = var.v-net
  location            = var.location
  resource_group_name = var.rg
  address_space       = var.vnet_addr_space
}

resource "azurerm_subnet" "subnet1" {
    name                  = var.subnet1
    resource_group_name   = var.rg
    virtual_network_name  = var.v-net
    address_prefixes      = var.subnet1_addr_space
}

resource "azurerm_subnet" "subnet2" {
  name                  = var.subnet2
  resource_group_name   = var.rg
  virtual_network_name  = var.v-net
  address_prefixes      = var.subnet2_addr_space
}

# network security group 1 with 1 security rule 
resource "azurerm_network_security_group" "nsg1" {
    name                = var.n-sg1
    location            = var.location
    resource_group_name = var.rg
    security_rule {
      name                       = "rule1"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
}

# network security group 2
resource "azurerm_network_security_group" "nsg2" {
  name                = var.n-sg2
  location            = var.location
  resource_group_name = var.rg
}

# network security group 2 - security rules
resource "azurerm_network_security_rule" "nsg2-rule1" { 
  name                        = "rule1"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg
  network_security_group_name = var.n-sg2
}

resource "azurerm_network_security_rule" "nsg2-rule2" {
  name                        = "rule2"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5985"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg
  network_security_group_name = var.n-sg2
}

# Subnet and Security Groups Associations

resource "azurerm_subnet_network_security_group_association" "netsg-asso1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_subnet_network_security_group_association" "netsg-asso2" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}

 