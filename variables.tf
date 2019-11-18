# Amazon Web Services Setup

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-west-2"
}

variable "aws_vpc_subnet" {
  default = "10.0.0.0/16"
}

variable "aws_ami" {
  default = "cio-3062-u16"
}

# SSH Setup
variable "ssh_key_public" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_user" {
  default = "ubuntu"
}

## Swarm setup

variable "swarm_name" {
  default = "swarm"
}

variable "swarm_master_count" {
  default = "1"
}

variable "swarm_worker_count" {
  default = "3"
}

variable "swarm_worker_storage_size" {
  default = "100"
}
