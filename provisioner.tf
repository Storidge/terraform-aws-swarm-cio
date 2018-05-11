resource "null_resource" "bootstrap_master" {
  count = "${var.swarm_master_count}"

  triggers {
    cluster_instance_ids = "${aws_instance.docker_swarm_master.*.id[count.index]}"
  }

  connection {
    host  = "${aws_instance.docker_swarm_master.*.public_ip[count.index]}"
    user  = "${var.ssh_user}"
    agent = true
  }

  provisioner "remote-exec" {
    inline = [
      "echo copy ssh key code here",
    ]
  }
}

resource "null_resource" "bootstrap_worker" {
  count = "${var.swarm_worker_count}"

  triggers {
    cluster_instance_ids = "${aws_instance.docker_swarm_worker.*.id[count.index]}"
  }

  connection {
    host  = "${aws_instance.docker_swarm_worker.*.public_ip[count.index]}"
    user  = "${var.ssh_user}"
    agent = true
  }

  provisioner "remote-exec" {
    when       = "destroy"
    on_failure = "continue"
    inline     = [
        "timeout 120 sudo cioctl remove"
    ]
  }

  provisioner "file" {
    content     = "${tls_private_key.storidge_deploy_key.private_key_pem}"
    destination = "deploykey.pem"
  }
}

resource "null_resource" "ansible_deploy" {
  triggers {
    cluster_instance_ids = "${join(",", null_resource.bootstrap_master.*.id)},${join(",", null_resource.bootstrap_worker.*.id)}"
  }

  connection {
    host  = "${aws_instance.docker_swarm_master.*.public_ip[count.index]}"
    user  = "${var.ssh_user}"
    agent = true
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ansible.hosts playbook.yml"
  }

  depends_on = [
    "null_resource.bootstrap_master",
    "null_resource.bootstrap_worker",
    "aws_volume_attachment.docker_swarm_worker_attachment01",
    "aws_volume_attachment.docker_swarm_worker_attachment02",
    "aws_volume_attachment.docker_swarm_worker_attachment03",
  ]
}
