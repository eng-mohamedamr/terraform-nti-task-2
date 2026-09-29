resource "aws_security_group" "ssh" {
  name        = "ssh-from-workstation"
  description = "Allow SSH only from workstation"

  ingress {
    description = "SSH from workstation"

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    cidr_blocks = [
      "${local.workstation_ip}/32"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "http" "my_ip" {
  url = "https://icanhazip.com"
}

locals {
  workstation_ip = chomp(data.http.my_ip.response_body)
}