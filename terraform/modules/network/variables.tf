variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "public_subnet_range" {
  type    = list(number)
  default = [2, 2]
}

variable "private_subnet_range" {
  type    = list(number)
  default = [2, 2]
}
variable "required_az_count" {
  type    = number
  default = 2
}