### Volumes needed for the sds master node
resource "aws_ebs_volume" "master_storage01" {
  count             = "${var.swarm_master_count}"
  availability_zone = "${aws_instance.docker_swarm_master.*.availability_zone[count.index]}"
  size              = "${var.swarm_worker_storage_size}"
  tags {
    Name = "${format("${var.swarm_name}-master-storage01-%02d", count.index)}"
  }
}

resource "aws_ebs_volume" "master_storage02" {
  count             = "${var.swarm_master_count}"
  availability_zone = "${aws_instance.docker_swarm_master.*.availability_zone[count.index]}"
  size              = "${var.swarm_worker_storage_size}"
  tags {
    Name = "${format("${var.swarm_name}-master-storage02-%02d", count.index)}"
  }
}

resource "aws_ebs_volume" "master_storage03" {
  count             = "${var.swarm_master_count}"
  availability_zone = "${aws_instance.docker_swarm_master.*.availability_zone[count.index]}"
  size              = "${var.swarm_worker_storage_size}"
  tags {
    Name = "${format("${var.swarm_name}-master-storage03-%02d", count.index)}"
  }
}

### Volumes needed for the worker nodes
resource "aws_ebs_volume" "worker_storage01" {
  count             = "${var.swarm_worker_count}"
  availability_zone = "${aws_instance.docker_swarm_worker.*.availability_zone[count.index]}"
  size              = "${var.swarm_worker_storage_size}"
  tags {
    Name = "${format("${var.swarm_name}-worker-storage01-%02d", count.index)}"
  }
}

resource "aws_ebs_volume" "worker_storage02" {
  count             = "${var.swarm_worker_count}"
  availability_zone = "${aws_instance.docker_swarm_worker.*.availability_zone[count.index]}"
  size              = "${var.swarm_worker_storage_size}"
  tags {
    Name = "${format("${var.swarm_name}-worker-storage02-%02d", count.index)}"
  }
}

resource "aws_ebs_volume" "worker_storage03" {
  count             = "${var.swarm_worker_count}"
  availability_zone = "${aws_instance.docker_swarm_worker.*.availability_zone[count.index]}"
  size              = "${var.swarm_worker_storage_size}"
  tags {
    Name = "${format("${var.swarm_name}-worker-storage03-%02d", count.index)}"
  }
}
