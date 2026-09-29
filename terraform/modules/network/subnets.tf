resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id = aws_vpc.main.id

  cidr_block = cidrsubnets(
    var.public_cidr,
    var.public_subnet_range[0],
    var.public_subnet_range[1]
  )[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true
}
resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.available.names)

  vpc_id = aws_vpc.main.id

  cidr_block = cidrsubnets(
    var.private_cidr,
    var.private_subnet_range[0],
    var.private_subnet_range[1]
  )[count.index]

  availability_zone = data.aws_availability_zones.available.names[count.index]
}