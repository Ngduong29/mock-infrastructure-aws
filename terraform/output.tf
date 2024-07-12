output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id1" {
  value = module.vpc.public_subnet_id1
}

# output "public_subnet_id2" {
#   value = module.vpc.public_subnet_id2
# }

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

# output "bastion_host_id" {
#   value = module.ec2.instance_bastion
# }

output "gitea_jenkins_server_id" {
  value = module.ec2.instance_gitea
}

# output "app_server_id" {
#   value = module.ec2.instance_server
# }


