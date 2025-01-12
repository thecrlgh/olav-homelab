module "bootstrap" {
  depends_on = [ module.volumes ]
  source     = "./bootstrap"

  proxmox_cluster = var.proxmox_cluster
  proxmox_ip      = var.proxmox_ip

  github_org        = var.github_org
  github_repository = var.github_repository
  github_branch     = var.github_branch

  sealed_secrets_cert = var.sealed_secrets_cert
  sealed_secrets_key  = var.sealed_secrets_key
}

module "volumes" {
  source     = "./volumes"

  proxmox_cluster = var.proxmox_cluster
  proxmox_ip      = var.proxmox_ip
  proxmox_node    = var.proxmox_node
}
