resource "null_resource" "proxmox-volume" {
  triggers = {
    storage         = var.storage
    vm_id           = var.vm_id
    name            = var.name
    size            = var.size
    format          = var.format
    host            = var.connection.host
    user            = var.connection.user
    private_key     = file(var.connection.private_key)
  }

  connection {
    type        = "ssh"
    host        = self.triggers.host
    user        = self.triggers.user
    private_key = self.triggers.private_key
  }

  provisioner "remote-exec" {
    inline = [
      "pvesm alloc ${self.triggers.storage} ${self.triggers.vm_id} ${self.triggers.name} ${self.triggers.size}G --format ${self.triggers.format}"
    ]
  }

  provisioner "remote-exec" {
    when   = destroy
    inline = [
        "pvesm free ${self.triggers.storage}:${self.triggers.name}"
    ]
  }

  lifecycle {
    prevent_destroy = true
  }
}
