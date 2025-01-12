variable "proxmox_cluster" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "proxmox_ip" {
  type = string
}

variable "proxmox_user" {
  type    = string
  default = "root"
}

variable "proxmox_storage" {
  type    = string
  default = "local-zfs"
}

variable "ssh_private_key" {
  type    = string
  default = "~/.ssh/id_rsa"
}
