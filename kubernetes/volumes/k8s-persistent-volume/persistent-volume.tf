resource "kubernetes_persistent_volume" "pv" {
  metadata {
    name = var.name
  }
  spec {
    capacity = {
      storage = "${var.size}Gi"
    }
    access_modes = var.access_modes
    storage_class_name = "proxmox-csi"
    persistent_volume_source {
      csi {
        driver = "csi.proxmox.sinextra.dev"
        fs_type = var.fs_type
        volume_handle = "${var.proxmox_cluster}/${var.proxmox_node}/${var.proxmox_storage}/vm-9999-pv-${var.name}"
        volume_attributes = {
          storage = var.proxmox_storage
        }
      }
    }
  }
}
