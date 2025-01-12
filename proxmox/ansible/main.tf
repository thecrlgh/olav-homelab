resource "null_resource" "ansible_playbook" {
  triggers = {
    host              = var.host
    user              = var.user 
    playbook_file     = var.playbook_file
    playbook_contents = file(var.playbook_file)
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.triggers.host}, -u ${self.triggers.user} ${self.triggers.playbook_file}"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }
}
