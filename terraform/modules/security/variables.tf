# data "http" "my_ip" {
#   url = "https://icanhazip.com"
# }

# locals {
#   workstation_ip = chomp(data.http.my_ip.response_body)
#   default_ingress = [{
#     description = "Allow SSH from my public IP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["${local.workstation_ip}/32"]
#   }]
# }

variable "ingress" {
  description = "List of ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
     description = "Allow SSH from my public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

variable "egress" {
  description = "List of egress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [{
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}
variable vpc_id {
  description = "The VPC ID where the security group will be created"
  type        = string
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs where the security group will be created"
  type = list(string)
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs where the security group will be created"
  type = list(string)
}