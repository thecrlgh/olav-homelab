resource "proxmox_virtual_environment_role" "csi" {
  role_id    = "CSI"
  privileges = [
    "VM.Audit",
    "VM.Config.Disk",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.Audit"
  ]
}

resource "proxmox_virtual_environment_user" "kubernetes-csi" {
  comment = "Managed by OpenTofu"
  user_id = "kubernetes-csi@pve"
  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.csi.role_id
  }
}

resource "proxmox_virtual_environment_user_token" "kubernetes-csi-token" {
  comment               = "Managed by OpenTofu"
  token_name            = "csi"
  user_id               = proxmox_virtual_environment_user.kubernetes-csi.user_id
  privileges_separation = false
}

resource "kubernetes_namespace" "csi-proxmox" {
  metadata {
    name = "csi-proxmox"
  }
}

resource "kubernetes_secret" "proxmox-csi-plugin" {
  metadata {
    name      = "proxmox-csi-plugin"
    namespace = kubernetes_namespace.csi-proxmox.id
  }

  data = {
    "config.yaml" = <<EOF
clusters:
- url: "https://${var.proxmox_ip}:8006/api2/json"
  insecure: true
  token_id: "${proxmox_virtual_environment_user_token.kubernetes-csi-token.id}"
  token_secret: "${element(split("=", proxmox_virtual_environment_user_token.kubernetes-csi-token.value), length(split("=", proxmox_virtual_environment_user_token.kubernetes-csi-token.value)) - 1)}"
  region: ${var.proxmox_cluster}
EOF
  }
}