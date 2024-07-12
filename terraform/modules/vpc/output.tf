output "vpc_id" {
  value = aws_vpc.this.id
}
output "public_subnet_id1" {
  value = aws_subnet.public_subnet1.id
}

# output "public_subnet_id2" {
#   value = aws_subnet.public_subnet2.id
# }

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.this.id
}

output "allow_http" {
  value = aws_security_group.allow_http.id
}

output "allow_ssh_private" {
  value = aws_security_group.allow_ssh_private.id
}

output "allow_ssh" {
  value = aws_security_group.allow_ssh.id
}