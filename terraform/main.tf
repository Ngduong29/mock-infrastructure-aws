provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  
}

module "ec2" {
  source = "./modules/ec2"
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  public_subnet_id = module.vpc.public_subnet_id1
  private_subnet_id = module.vpc.private_subnet_id
  security_group_http_id = module.vpc.allow_http
  security_group_ssh_private_id = module.vpc.allow_ssh_private
  security_group_ssh_id = module.vpc.allow_ssh
  public_key = var.public_key
  
}

