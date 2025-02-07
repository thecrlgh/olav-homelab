locals {
  module_path  = trim(replace(path.module, path.root, ""), "/")
}

module "playbook-hdd-spindown" {
  source = "./ansible"

  host = var.proxmox_ip
  user = "root"

  playbook_file = "${local.module_path}/playbooks/hdd-spindown.yaml"
}

module "playbook-pci-passthrough" {
  source = "./ansible"

  host = var.proxmox_ip
  user = "root"

  playbook_file = "${local.module_path}/playbooks/pci-passthrough.yaml"
}

module "playbook-repositories" {
  source = "./ansible"

  host = var.proxmox_ip
  user = "root"

  playbook_file = "${local.module_path}/playbooks/repositories.yaml"
}

module "playbook-vendor-reset" {
  source = "./ansible"

  host = var.proxmox_ip
  user = "root"

  playbook_file = "${local.module_path}/playbooks/vendor-reset.yaml"
}

module "playbook-zfs-backup" {
  source = "./ansible"

  host = var.proxmox_ip
  user = "root"

  playbook_file = "${local.module_path}/playbooks/zfs-backup.yaml"
}

module "playbook-zfs-send" {
  source = "./ansible"

  host = var.proxmox_ip
  user = "root"

  playbook_file = "${local.module_path}/playbooks/zfs-send.yaml"
}

module "playbook-zfs-snapshots" {
  source = "./ansible"

  host = var.proxmox_ip
  user = "root"

  playbook_file = "${local.module_path}/playbooks/zfs-snapshots.yaml"
}
