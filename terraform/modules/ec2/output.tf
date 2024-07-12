output "instance_gitea" {
  value = aws_instance.gitea_jenkins
}

output "instance_ip" {
  value = aws_instance.gitea_jenkins.public_ip
}
# output "instance_bastion" {
#   value = aws_instance.bastion
# }
# output "instance_server" {
#   value = aws_instance.app_server
# }