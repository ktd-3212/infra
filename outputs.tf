output "website_url" {
  description = "Địa chỉ IP Public Webserver"
  value       = "http://${aws_instance.daidh_webserver.public_ip}"
}

output "vpc_id" {
  description = "ID của VPC được tạo"
  value       = aws_vpc.daidh_vpc.id
}
