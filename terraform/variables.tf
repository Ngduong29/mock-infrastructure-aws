variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "ec2_ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "public_key" {
  description = "public-key"
  type        = string
}
