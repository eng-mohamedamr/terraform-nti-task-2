resource "aws_instance" "bastion" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  public_ip    = true
  subnet_id    = aws_subnet.public[0].id
  tags = {
    Name = var.instance_name
  }
}
resource "null_resource" "bastion_provisioner" {
  depends_on = [time_sleep.wait_45_seconds]

  provisioner "remote-exec" {
    inline = [
    "echo 'SSH daemon initialized successfully!'",
    "sudo apt-get update -y",
    "sudo apt-get install -y jq",
    "echo 'installation completed successfully!'"
    ]
  }
  provisioner "local-exec" {
      command = "echo public_ip = ${aws_instance.bastion.public_ip} > ${path.module}/bastion_public_ip.txt"
    }

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = aws_instance.bastion.public_ip
    }
  }

