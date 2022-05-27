# using the VPC module to create a VPC:
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs = ["${var.region}a", "${var.region}b"]
  public_subnets = [
    cidrsubnet(var.vpc_cidr, 8, 0),
    cidrsubnet(var.vpc_cidr, 8, 1)
  ]

  private_subnets = [
    cidrsubnet(var.vpc_cidr, 8, 2),
    cidrsubnet(var.vpc_cidr, 8, 3)
  ]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true


  tags = {
    Name    = var.vpc_name
    Project = "hands-on.cloud"
  }
}

#create a security group :
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [var.vpc_cidr]
}