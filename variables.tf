variable "proxmox_ip" {
  type    = string
  default = "192.168.0.190"
}

variable "proxmox_node" {
  type    = string
  default = "pve-alpha"
}

variable "proxmox_cluster" {
  type    = string
  default = "homelab"
}

variable "github_org" {
  type    = string
  default = "olav-st"
}

variable "github_repository" {
  type    = string
  default = "homelab"
}

variable "github_branch" {
  type    = string
  default = "main"
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "cluster_name" {
  type    = string
  default = "homelab"
}

variable "home_assistant_vm_id" {
  type    = number
  default = 100
}

variable "default_gateway" {
  type    = string
  default = "192.168.0.1"
}

variable "cluster_vip" {
  type    = string
  default = "192.168.0.90"
}

variable "sealed_secrets_cert" {
  type      = string
  sensitive = true
}

variable "sealed_secrets_key" {
  type      = string
  sensitive = true
}
