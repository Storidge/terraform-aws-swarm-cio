### Resolve correct ami id
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["cio-3186-u16"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["565054200205"]
}

### Setup Swarm master
resource "aws_instance" "docker_swarm_master" {
  count         = "${var.swarm_master_count}"
  instance_type = "t3.large"
  ami           = "${data.aws_ami.ubuntu.id}"
  key_name      = "${aws_key_pair.auth.id}"
  subnet_id     = "${aws_subnet.storidge.id}"

  associate_public_ip_address = "true"

  vpc_security_group_ids = [
    "${aws_security_group.storidge.id}"
  ]

  tags {
    Name = "${format("${var.swarm_name}-master-%02d", count.index)}"
  }
}

resource "aws_volume_attachment" "docker_swarm_master_attachment01" {
  count        = "${var.swarm_master_count}"
  device_name  = "/dev/xvdb"
  instance_id  = "${aws_instance.docker_swarm_master.*.id[count.index]}"
  volume_id    = "${aws_ebs_volume.master_storage01.*.id[count.index]}"
  force_detach = "true"
}

resource "aws_volume_attachment" "docker_swarm_master_attachment02" {
  count        = "${var.swarm_master_count}"
  device_name  = "/dev/xvdc"
  instance_id  = "${aws_instance.docker_swarm_master.*.id[count.index]}"
  volume_id    = "${aws_ebs_volume.master_storage02.*.id[count.index]}"
  force_detach = "true"
}

resource "aws_volume_attachment" "docker_swarm_master_attachment03" {
  count        = "${var.swarm_master_count}"
  device_name  = "/dev/xvdd"
  instance_id  = "${aws_instance.docker_swarm_master.*.id[count.index]}"
  volume_id    = "${aws_ebs_volume.master_storage03.*.id[count.index]}"
  force_detach = "true"
}

### Setup Swarm worker
resource "aws_instance" "docker_swarm_worker" {
  count         = "${var.swarm_worker_count}"
  instance_type = "t3.large"
  ami           = "${data.aws_ami.ubuntu.id}"
  key_name      = "${aws_key_pair.auth.id}"
  subnet_id     = "${aws_subnet.storidge.id}"

  associate_public_ip_address = "true"

  vpc_security_group_ids = [
    "${aws_security_group.storidge.id}"
  ]

  tags {
    Name = "${format("${var.swarm_name}-worker-%02d", count.index)}"
  }
}

resource "aws_volume_attachment" "docker_swarm_worker_attachment01" {
  count        = "${var.swarm_worker_count}"
  device_name  = "/dev/xvdb"
  instance_id  = "${aws_instance.docker_swarm_worker.*.id[count.index]}"
  volume_id    = "${aws_ebs_volume.worker_storage01.*.id[count.index]}"
  force_detach = "true"
}

resource "aws_volume_attachment" "docker_swarm_worker_attachment02" {
  count        = "${var.swarm_worker_count}"
  device_name  = "/dev/xvdc"
  instance_id  = "${aws_instance.docker_swarm_worker.*.id[count.index]}"
  volume_id    = "${aws_ebs_volume.worker_storage02.*.id[count.index]}"
  force_detach = "true"
}

resource "aws_volume_attachment" "docker_swarm_worker_attachment03" {
  count        = "${var.swarm_worker_count}"
  device_name  = "/dev/xvdd"
  instance_id  = "${aws_instance.docker_swarm_worker.*.id[count.index]}"
  volume_id    = "${aws_ebs_volume.worker_storage03.*.id[count.index]}"
  force_detach = "true"
}
