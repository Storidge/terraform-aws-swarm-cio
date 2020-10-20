resource "aws_key_pair" "auth" {
  key_name   = "var.swarm_name-ssh-key"
  public_key = "PUBLIC_KEY_HERE"
}
