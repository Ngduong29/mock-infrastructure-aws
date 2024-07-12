# VPC
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

#Internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

# Public Subnet
resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet1"
  }
}

# resource "aws_subnet" "public_subnet2" {
#   vpc_id = aws_vpc.this.id
#   cidr_block = "10.0.2.0/24"
#   availability_zone = "ap-southeast-1b"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "public_subnet2"
#   }
# }

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.this.id
  cidr_block = var.private_subnet_cidr_block

  tags = {
    Name = "private_subnet"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "public_route_table"
  }
}
#liên kết route table với public subnets
resource "aws_route_table_association" "public1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public.id
}
# resource "aws_route_table_association" "public2" {
#   subnet_id = aws_subnet.public_subnet2.id
#   route_table_id = aws_route_table.public.id
# }

# NAT Gateway
resource "aws_eip" "nat" {
  depends_on = [ aws_internet_gateway.this ]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public_subnet1.id
  tags = {
    Name = "NAT 1"
    }

}

#Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_http" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_security_group" "allow_ssh_private" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_ssh.id]
  }

  tags = {
    Name = "allow_ssh_private"
  }
}