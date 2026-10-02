variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "private_cidr" {
  type    = string
  default = "10.0.2.0/24"
}
variable "public_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "private_subnet_range" {
  type    = list(number)
  default = [2, 2]
}
variable "public_subnet_range" {
  type    = list(number)
  default = [2, 2]
}
variable "az_count" {
  type    = number
  default = 2
}
locals {
  az_names          = slice(data.aws_availability_zones.available.names, 0, var.az_count)
  is_prod           = terraform.workspace == "prod"
  nat_gateway_count = local.is_prod ? length(local.az_names) : 1
}
variable "permission" {
  description = "The permission to use for the SSH key pair"
  type        = string
  default     = "0400"
}
variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = "t3.micro"
}
variable "instance_ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string
  default     = "ami-0aba19e56f3eaec05"
}
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