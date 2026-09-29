resource aws_vpc "main" {
  cidr_block = var.vpc_cidr
  lifecycle {
    precondition {
      condition = length(data.aws_availability_zones.available.names) >= var.required_az_count

      error_message = "The selected AWS region must have at least ${var.required_az_count} available Availability Zones."
    }
  }
}
