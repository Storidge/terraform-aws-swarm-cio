resource "null_resource" "bootstrap_master" {
  count = var.swarm_master_count

  triggers = {
    cluster_instance_ids = aws_instance.docker_swarm_master.*.id[count.index]
  }

  connection {
    host  = aws_instance.docker_swarm_master.*.public_ip[count.index]
    user  = var.ssh_user
    agent = true
  }
  provisioner "remote-exec" {
    inline = [
      "echo PUBLIC_KEY_HERE",
    ]
  }
}

resource "null_resource" "bootstrap_worker" {
  count = var.swarm_worker_count

  triggers = {
    cluster_instance_ids = aws_instance.docker_swarm_worker.*.id[count.index]
    cluster_instance_ips = aws_instance.docker_swarm_worker.*.public_ip[count.index]
    cluster_user_id = var.ssh_user
  }

  connection {
    host  = "${self.triggers.cluster_instance_ips}"
    user  = "${self.triggers.cluster_user_id}"
    agent = false
    private_key = "${file("PATH_TO_PRIVATE_KEY")}"
  }

  provisioner "remote-exec" {
    when       = destroy
    on_failure = continue
    inline     = [
        "timeout 120 sudo cioctl remove"
    ]
  }

  provisioner "file" {
    content     = tls_private_key.storidge_deploy_key.private_key_pem
    destination = "deploykey.pem"
  }
}

resource "null_resource" "ansible_deploy" {
  count = var.swarm_master_count

  triggers = {
    cluster_instance_ids = "${join(",", null_resource.bootstrap_master.*.id)}-${join(",", null_resource.bootstrap_worker.*.id)}"
  }

  connection {
    host  = aws_instance.docker_swarm_master.*.public_ip[count.index]
    user  = var.ssh_user
    agent = false
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ansible.hosts playbook.yml"
  }

  depends_on = [
    null_resource.bootstrap_master,
    null_resource.bootstrap_worker,
    aws_volume_attachment.docker_swarm_worker_attachment01,
    aws_volume_attachment.docker_swarm_worker_attachment02,
    aws_volume_attachment.docker_swarm_worker_attachment03,
  ]
}
