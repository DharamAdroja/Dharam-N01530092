variable "rg" {
  default = "network-rg"
  type = string
  description = "This is resource group 1"
}

variable "location" {
    default = "Australia Southeast"
}

variable "v-net" {
    default = "network-vnet"
}

variable "vnet_addr_space" {
    default = ["10.0.0.0/16"]
}

variable "subnet1" {
    default = "network-subnet1"
}

variable "subnet2" {
    default = "network-subnet2"
}

variable "subnet1_addr_space" {
    default = ["10.0.1.0/24"]
}

variable "subnet2_addr_space" {
    default = ["10.0.2.0/24"] 
}

variable "n-sg1" {
    default = "network-nsg1"
}

variable "n-sg2" {
  default = "network-nsg2"
}
