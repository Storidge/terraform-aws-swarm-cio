resource "aws_vpc" "storidge" {
  cidr_block = "${var.aws_vpc_subnet}"

  tags {
    Name = "${var.swarm_name}-vpc}"
  }
}

resource "aws_internet_gateway" "storidge" {
  vpc_id = "${aws_vpc.storidge.id}"

  tags {
    Name = "${var.swarm_name}-gateway}"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.storidge.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.storidge.id}"
}

resource "aws_subnet" "storidge" {
  vpc_id                  = "${aws_vpc.storidge.id}"
  cidr_block              = "${cidrsubnet(var.aws_vpc_subnet, 8, 2)}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.swarm_name}-subnet}"
  }
}
