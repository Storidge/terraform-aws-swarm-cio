data "template_file" "ansible_master" {
  count    = var.swarm_master_count
  template = "$${name} ansible_host=$${ipaddr} ansible_user=$${user} private_ip=$${private}"
  vars = {
    name    = format("${var.swarm_name}-master-%02d", count.index)
    ipaddr  = aws_instance.docker_swarm_master.*.public_ip[count.index]
    private = aws_instance.docker_swarm_master.*.private_ip[count.index]
    user    = var.ssh_user
  }
}

data "template_file" "ansible_worker" {
  count     = var.swarm_worker_count
  template  = "$${name} ansible_host=$${ipaddr} ansible_user=$${user} private_ip=$${private}"
  vars = {
    name    = format("var.swarm_name-worker-%02d", count.index)
    ipaddr  = aws_instance.docker_swarm_worker.*.public_ip[count.index]
    private = aws_instance.docker_swarm_worker.*.private_ip[count.index]
    user    = var.ssh_user
  }
}

data "template_file" "ansible_inventory" {
  template = "[masters]\n$${masters}\n\n[workers]\n$${workers}\n\n[all:vars]\ndeploy_pub_key=$${pubkey}"
  vars = {
    masters = join("\n",data.template_file.ansible_master.*.rendered)
    workers = join("\n",data.template_file.ansible_worker.*.rendered)
    pubkey  = tls_private_key.storidge_deploy_key.public_key_openssh
  }
}

resource "local_file" "ansible_inventory" {
    content  = data.template_file.ansible_inventory.rendered
    filename = "path.module/ansible.hosts"
}
