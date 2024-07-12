resource "aws_instance" "bastion" {
  ami = var.ami
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  security_groups = [var.security_group_ssh_id]
  key_name = "aws_ec2_gitea_jenkin"
  tags = {
    Name = "Bastion_host"
  }
}

resource "aws_instance" "gitea_jenkins" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  security_groups = [var.security_group_ssh_id]
  key_name = "aws_ec2_gitea_jenkin"
  tags = {
    Name = "Gitea_jenkins"
  }

}

resource "aws_key_pair" "gitea_jenkins_public_key" {
  key_name = "aws_ec2_gitea_jenkin"
  public_key = var.public_key
}

resource "aws_instance" "app_server" {
  ami = var.ami
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_id
  security_groups = [var.security_group_ssh_private_id]
  key_name = "aws_ec2_gitea_jenkin"
  tags = {
    Name = "App_server"
  }
}