variable "ami" {
  description = "The AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "public_subnet_id" {
  description = "The subnet ID to deploy the instance in"
  type        = string
}

variable "private_subnet_id" {
  description = "The private subnet ID to deploy the instance in"
  type        = string
}

variable "security_group_ssh_private_id"{
  description = "The private subnet ID to deploy the instance in"
  type        = string
}

variable "security_group_ssh_id"{
  description = "The private subnet ID to deploy the instance in"
  type        = string
}
variable "security_group_http_id"{
  description = "The private subnet ID to deploy the instance in"
  type        = string
}

variable "public_key" {
  description = "public-key"
  type        = string
}
