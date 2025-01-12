variable "proxmox_cluster" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "proxmox_ip" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_vip" {
  type = string
}

variable "controlplane_count" {
  type = number
  default = 1
}

variable "default_gateway" {
  type = string
}

variable "github_org" {
  type = string
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "github_repository" {
  type = string
}

variable "github_branch" {
  type = string
}

variable "sealed_secrets_cert" {
  type      = string
  sensitive = true
}

variable "sealed_secrets_key" {
  type      = string
  sensitive = true
}

variable "subnet_mask" {
  type    = number
  default = 24
}

variable "worker_count" {
  type = number
  default = 0
}
