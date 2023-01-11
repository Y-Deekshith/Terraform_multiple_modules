resource "aws_vpc" "modulevpc1" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = true

  tags = {
    Name = var.name
    Env = var.env
  }
}