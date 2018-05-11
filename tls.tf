resource "tls_private_key" "storidge_deploy_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
