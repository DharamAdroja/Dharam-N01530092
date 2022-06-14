locals {
    common_tags = {
        Name         = "Terraform-Class"
        Project      = "Learning"
        ContactEmail = "n01530092@humbermail.ca"
        Environment  = "Lab"
    }
}

variable "los_disk_attr" {
    type    = map(string)
    default = {
        storage_account_type = "Premium_LRS"
        disk_size            = "32"
        disk_caching         = "ReadWrite"
        disk_name            = "os-disk"
    }
}

variable "admin_credentials" {
    type    = map(string)
    default = {
        Username = "Dharam-n01530092"
        Password = "dharam@0092"
    }
}

variable "vm_size" {
    default = "Standard_B1s"
}

variable "vm_name" {
    default = "lab05s1-dharam"
}

variable "los_image_info" {
  type    = map(string)
  default = {
    Publisher = "Canonical"
    Offer     = "UbuntuServer"
    Sku       = "19.04"
    Version   = "latest"
  }
}

variable "pubip_dns_label" {
  default = "pubip-dns"
}

variable "allocation_method" {
  default = "Dynamic"
}

variable "nb_count" {
  default = "2"
}

variable "linux_avs" {
  default = "linux_avs"
}