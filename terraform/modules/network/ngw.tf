
resource "null_resource" "region_check" {
  lifecycle {
    precondition {
      condition     = length(data.aws_availability_zones.available.names) >= var.az_count
      error_message = "The selected AWS region does not have enough Availability Zones."
    }
  }
}

resource "aws_eip" "nat" {
  count      = local.nat_gateway_count
  domain     = "vpc"
  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "${terraform.workspace}-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = local.nat_gateway_count
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "${terraform.workspace}-nat-gw-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.gw]
}



