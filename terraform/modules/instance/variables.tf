variable "key_algorithm" {
  description = "The algorithm to use for the SSH key pair"
  type        = string
  default     = "RSA"
}
variable "algorithm_bits" {
  description = "The algorithm to use for the SSH key pair"
  type        = number
  default     = 4096
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
variable "instance_name" {
  description = "The name to use for the EC2 instance"
  type        = string
  default     = "Bastion-Instance"
}