resource "aws_route_table" "mrtb" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "${var.name}-Mrtb"
  }
}

resource "aws_route_table" "crtb" {
  vpc_id = var.vpc_id

    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = var.natgw_id
    }
  tags = {
    Name = "${var.name}-Crtb"
  }
}