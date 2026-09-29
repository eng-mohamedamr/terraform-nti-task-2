resource "tls_private_key" "ssh_key" {
  algorithm = var.key_algorithm
  rsa_bits  = var.algorithm_bits
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${terraform.workspace}-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_sensitive_file" "private_key_pem" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/${terraform.workspace}-private-key.pem"
  file_permission = var.permission
}
