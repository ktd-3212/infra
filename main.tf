# Cấu hình AWS Provider (Nhà cung cấp Cloud)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region # Lấy giá trị từ variables.tf
}

# 1. Tạo VPC
resource "aws_vpc" "daidh_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "daidh_vpc"
  }
}

# 2. Tạo Internet Gateway (IGW)
resource "aws_internet_gateway" "daidh_igw" {
  vpc_id = aws_vpc.daidh_vpc.id
  tags = {
    Name = "daidh_igw"
  }
}

# 3. Tạo Public Subnet 
resource "aws_subnet" "daidh_public_subnet" {
  vpc_id                  = aws_vpc.daidh_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true # Tự động gán Public IP cho các EC2
  availability_zone       = var.aws_az
  tags = {
    Name = "daidh_public_subnet"
  }
}

# 4. Tạo Route Table cho Public Subnet
resource "aws_route_table" "daidh_public_rt" {
  vpc_id = aws_vpc.daidh_vpc.id
  tags = {
    Name = "daidh_public_rt"
  }
}

# 5. Thêm Route Internet vào Public Route Table
resource "aws_route" "daidh_internet_route" {
  route_table_id         = aws_route_table.daidh_public_rt.id
  destination_cidr_block = "0.0.0.0/0" # Định tuyến tất cả lưu lượng ra Internet
  gateway_id             = aws_internet_gateway.daidh_igw.id
}

# 6. Gắn Public Subnet với Public Route Table
resource "aws_route_table_association" "daidh_public_subnet_association" {
  subnet_id      = aws_subnet.daidh_public_subnet.id
  route_table_id = aws_route_table.daidh_public_rt.id
}

# 7. Tạo Security Group cho EC2 Instance (Allow SSH và HTTP)
resource "aws_security_group" "daidh_sg" {
  name        = "daidh-web-sg"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.daidh_vpc.id

  # Ingress Rule: Allow HTTP (Port 80) từ mọi nơi
  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress Rule: Allow SSH (Port 22) từ mọi nơi 
  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress Rule: Allow tất cả lưu lượng đi ra
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # ALL protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "daidh-sg"
  }
}

# 8. Tạo Instance EC2
resource "aws_instance" "daidh_webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.daidh_public_subnet.id
  # Gán Security Group đã tạo
  security_groups = [aws_security_group.daidh_sg.id]
  key_name        = var.key_name
  user_data       = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello from daidh devops 2503 EC2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "daidh_webserver"
  }
}
