variable "proxmox_ip" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "letsencrypt_contact_email" {
  type = string
}

variable "cloudflare_dns_email" {
  type = string
}

variable "cloudflare_dns_token" {
  type      = string
  sensitive = true
}
