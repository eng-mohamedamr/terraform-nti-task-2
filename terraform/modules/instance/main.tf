resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
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


resource "aws_instance" "bastion" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name
  # public_ip    = true
  subnet_id = var.public_subnet_ids[0]
  tags = {
    Name = "bastion-${terraform.workspace}"
  }
}

resource "time_sleep" "wait_45_seconds" {
  create_duration = "45s"

  depends_on = [aws_instance.bastion]
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

