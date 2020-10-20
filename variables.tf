# Amazon Web Services Setup

variable "aws_access_key" {
  default= "AWS_ACCESS_KEY"
}

variable "aws_secret_key" {
  default="AWS_SECRET_KEY"
}

variable "ssh_fingerprint" {
  default="SSH_MD5_FINGERPRINT"
}

variable "pub_key" {
  default="PATH_TO_PUB_KEY"
}

variable "pvt_key" {
  default="PATH_TO_PVT_KEY"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "aws_vpc_subnet" {
  default = "10.0.0.0/16"
}

variable "aws_ami" {
  default = "cio-3411-u16"
}

# SSH Setup
variable "ssh_key_public" {
  default = "PATH_TO_PUB_KEY"
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
