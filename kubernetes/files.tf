resource "proxmox_virtual_environment_download_file" "talos_image" {
  for_each     = local.images
  content_type = "iso"
  datastore_id = "local"
  node_name    =  var.proxmox_node

  file_name               = each.value.file_name
  url                     = each.value.url
  decompression_algorithm = each.value.decompression_algorithm
  overwrite               = false
}
