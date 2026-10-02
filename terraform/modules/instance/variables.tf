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
variable "public_subnet_ids" {
  description = "List of public subnet IDs where the EC2 instance will be launched"
  type = list(string)
}