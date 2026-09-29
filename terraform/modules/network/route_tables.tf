resource "aws_route_table" "private" {
  count  = length(local.az_names)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = local.is_prod ? aws_nat_gateway.nat[count.index].id : aws_nat_gateway.nat[0].id
  }

  tags = {
    Name = "${terraform.workspace}-private-rt-${count.index + 1}"
  }
}
resource "aws_route_table_association" "private" {
  count          = length(local.az_names)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

