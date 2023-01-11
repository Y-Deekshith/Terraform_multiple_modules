resource "aws_subnet" "modulepublic_subnets" {
  count             = length(var.publicsubnet_cidr_block)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.publicsubnet_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.name}-publicsubnet-${count.index + 1}"
  }
}

resource "aws_subnet" "moduleprivate_subnets" {
  count             = 1
  vpc_id            = var.vpc_id
  cidr_block        = element(var.privatesubnet_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.name}-privatesubnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "publicroute" {
  count          = length(var.publicsubnet_cidr_block)
  subnet_id      = element(aws_subnet.modulepublic_subnets.*.id, count.index)
  route_table_id = var.mrtb_route_table
}
resource "aws_route_table_association" "privateroute" {
  count          = length(var.privatesubnet_cidr_block)
  subnet_id      = element(aws_subnet.moduleprivate_subnets.*.id, count.index)
  route_table_id = var.crtb_route_table
}