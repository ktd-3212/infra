variable "aws_region" {
  description = "Region AWS để triển khai tài nguyên"
  type        = string
  default     = "ap-southeast-1" # 
}

variable "aws_az" {
  description = "Availability Zone để triển khai subnet (ví dụ: ap-southeast-1a)"
  type        = string
  default     = "ap-southeast-1a" #
}

variable "vpc_cidr_block" {
  description = "Dải CIDR cho VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "Dải CIDR cho Public Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "ID của AMI (Amazon Linux 2)"
  type        = string
  default     = "ami-088d74defe9802f14" # Thay đổi ID này theo Region
}

variable "instance_type" {
  description = "Loại EC2 Instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Tên cặp khoá SSH (Khai báo trong AWS)"
  type        = string
  default     = "my-ec2-keypair" 
}
