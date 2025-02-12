module "proxmox" {
  source                    = "./proxmox"
  proxmox_node              = var.proxmox_node
  proxmox_ip                = var.proxmox_ip
  letsencrypt_contact_email = var.letsencrypt_contact_email
  cloudflare_dns_email      = var.letsencrypt_contact_email
  cloudflare_dns_token      = var.cloudflare_dns_token
}

module "home-assistant" {
  source        = "./home-assistant"
  proxmox_node  = var.proxmox_node
  proxmox_vm_id = var.home_assistant_vm_id
}

module "kubernetes" {
  source = "./kubernetes"

  cluster_name = var.cluster_name

  sealed_secrets_cert = var.sealed_secrets_cert
  sealed_secrets_key  = var.sealed_secrets_key

  github_org        = var.github_org
  github_token      = var.github_token
  github_repository = var.github_repository
  github_branch     = var.github_branch

  proxmox_ip          = var.proxmox_ip
  proxmox_cluster     = var.proxmox_cluster
  proxmox_node        = var.proxmox_node

  default_gateway = var.default_gateway
  cluster_vip     = var.cluster_vip
}

output "talosconfig" {
  value = module.kubernetes.talosconfig
  sensitive = true
}

output "kubeconfig" {
  value = module.kubernetes.kubeconfig.kubeconfig_raw
  sensitive = true
}
