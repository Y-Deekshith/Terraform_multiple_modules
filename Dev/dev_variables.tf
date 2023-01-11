module "dev_vpc" {
  source           = "../Modules/vpc"
  vpc_cidr_block   = "10.10.0.0/16"
  instance_tenancy = "default"
  name             = "dev_infra"
  env              = "development"
}
module "dev_subnets" {
  source                   = "../Modules/subnets"
  azs                      = ["us-east-1a", "us-east-1b"]
  publicsubnet_cidr_block  = ["10.10.1.0/24", "10.10.2.0/24"]
  name                     = module.dev_vpc.name
  privatesubnet_cidr_block = ["10.10.20.0/24"]
  vpc_id                   = module.dev_vpc.vpc_id
  mrtb_route_table         = module.dev_routing.mrtb_route_table
  crtb_route_table         = module.dev_routing.crtb_route_table
}
module "dev_security" {
  source         = "../Modules/security"
  sg_cidr_blocks = ["0.0.0.0/0"]
  name           = module.dev_vpc.name
  vpc_id         = module.dev_vpc.vpc_id
}
module "dev_routing" {
  source = "../Modules/routing"
  name   = module.dev_vpc.name
  # public_subnet_list  = [module.dev_subnets.public_subnet_list]
  # private_subnet_list = [module.dev_subnets.private_subnet_list]
  vpc_id   = module.dev_vpc.vpc_id
  igw_id   = module.dev_gateway.igw_id
  natgw_id = module.dev_gateway.natgw_id
}
module "dev_gateway" {
  source         = "../Modules/gateway"
  name           = module.dev_vpc.name
  vpc_id         = module.dev_vpc.vpc_id
  publicsubnet_1 = module.dev_subnets.public_subnet_list_1
}

module "dev_ec2" {
  source                   = "../Modules/ec2"
  instancetype             = "t2.micro"
  ami                      = "ami-06878d265978313ca"
  key_name                 = "NVirginiaPC"
  name                     = module.dev_vpc.name
  publicsubnet_cidr_block  = module.dev_subnets.public_subnet_list
  privatesubnet_cidr_block = module.dev_subnets.private_subnet_list
  security_group           = module.dev_security.security_group
  env                      = module.dev_vpc.vpc_env
  private_ec2_depends_on   = module.dev_gateway.natgw_id
}
module "dev_alb" {
  source                  = "../Modules/alb"
  security_groups         = module.dev_security.security_group
  publicsubnet_cidr_block = module.dev_subnets.public_subnet_list
  name                    = module.dev_vpc.name
  env                     = module.dev_vpc.vpc_env
  vpc_id                  = module.dev_vpc.vpc_id
}