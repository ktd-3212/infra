variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
}
variable "aws_az" {
  description = "Availability Zone để triển khai subnet"
  type        = string
  default     = "ap-southeast-1a" # Thay đổi theo AZ trong Region của bạn
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
  default     = "ami-0b04e67272714c776" # Thay đổi ID này theo Region
}

variable "instance_type" {
  description = "Loại EC2 Instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Tên cặp khoá SSH (đã có trong AWS)"
  type        = string
  # Bạn CẦN thay thế giá trị này bằng tên Key Pair thực tế của mình
  default     = "my-ec2-keypair" 
}
