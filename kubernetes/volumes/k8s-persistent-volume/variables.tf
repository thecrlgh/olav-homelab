variable "name" {
  type = string
}

variable "size" {
  type = number
}

variable "access_modes" {
  type    = list(string)
  default = [ "ReadWriteOnce" ]
}

variable "fs_type" {
  type    = string
  default = "ext4"
}

variable "proxmox_cluster" {
  type    = string
}

variable "proxmox_node" {
  type    = string
}

variable "proxmox_storage" {
  type    = string
  default = "local-zfs"
}
