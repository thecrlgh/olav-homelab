resource "talos_machine_secrets" "this" {}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = flatten([for name, node in local.nodes : local.node_ips[name] if node.type == "controlplane"])
}

data "talos_machine_configuration" "this" {
  for_each = local.nodes

  cluster_name     = var.cluster_name
  cluster_endpoint = "https://${var.cluster_vip}:6443"
  machine_type     = each.value.type
  machine_secrets  = talos_machine_secrets.this.machine_secrets
  config_patches = [
    templatefile("kubernetes/talos/machineconfig.yaml.tftpl", {
      hostname        = each.key
      type            = each.value.type
      cluster_vip     = var.cluster_vip
      proxmox_cluster = var.proxmox_cluster
      proxmox_node    = var.proxmox_node
      inline_manifests = [
        {
          name     = "cilium-install"
          contents = templatefile("kubernetes/talos/cilium-install.yaml.tftpl", {})
        }
      ]
    }),
  ]
}

resource "talos_machine_configuration_apply" "this" {
  depends_on = [proxmox_virtual_environment_vm.talos]
  for_each   = local.nodes

  client_configuration        = data.talos_client_configuration.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this[each.key].machine_configuration
  node                        = local.node_ips[each.key][0]

  on_destroy = {
    graceful = true
    reboot   = false
    reset    = true
  }
}

resource "talos_machine_bootstrap" "this" {
  depends_on = [talos_machine_configuration_apply.this]

  client_configuration = data.talos_client_configuration.this.client_configuration
  node                 = local.node_ips[local.bootstrap_node][0]
}

data "talos_cluster_health" "this" {
  depends_on = [talos_machine_configuration_apply.this]

  client_configuration = data.talos_client_configuration.this.client_configuration
  control_plane_nodes  = flatten([for name, node in local.nodes : local.node_ips[name] if node.type == "controlplane"])
  worker_nodes         = flatten([for name, node in local.nodes : local.node_ips[name] if node.type == "worker"])
  endpoints            = data.talos_client_configuration.this.endpoints
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on           = [talos_machine_bootstrap.this]

  client_configuration = data.talos_client_configuration.this.client_configuration
  node                 = var.cluster_vip
}

output "talosconfig" {
  value     = data.talos_client_configuration.this.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.this
  sensitive = true
}
