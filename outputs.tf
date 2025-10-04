output "website_url" {
  description = "Địa chỉ IP công cộng của Webserver"
  value       = "http://${aws_instance.k21_webserver.public_ip}"
}

output "vpc_id" {
  description = "ID của VPC được tạo"
  value       = aws_vpc.k21_vpc.id
}
