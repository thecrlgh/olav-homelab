resource "proxmox_virtual_environment_acme_account" "letsencrypt" {
  name      = "letsencrypt"
  contact   = var.letsencrypt_contact_email
  directory = "https://acme-v02.api.letsencrypt.org/directory"
  tos       = "https://letsencrypt.org/documents/LE-SA-v1.3-September-21-2022.pdf"
}

resource "proxmox_virtual_environment_acme_dns_plugin" "cloudflare_dns" {
  plugin = "cloudflare-dns"
  api    = "cf"
  data = {
    CF_Email = var.cloudflare_dns_email
    CF_Token = var.cloudflare_dns_token
  }
}
