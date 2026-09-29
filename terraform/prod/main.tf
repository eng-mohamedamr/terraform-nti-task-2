data "aws" "public_ip" {
  url = "https://icanhazip.com"
}
data "aws_availability_zones" "available" {
  state = "available"
}