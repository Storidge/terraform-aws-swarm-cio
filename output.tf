output "swarm_master_address" {
  value = "${join(",", aws_instance.docker_swarm_master.*.public_ip)}"
}

output "swarm_worker_address" {
  value = "${join(",", aws_instance.docker_swarm_worker.*.public_ip)}"
}
