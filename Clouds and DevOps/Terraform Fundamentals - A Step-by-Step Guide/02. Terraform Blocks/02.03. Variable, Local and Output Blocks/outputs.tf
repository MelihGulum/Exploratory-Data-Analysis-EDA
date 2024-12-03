output "instance_id" {
  value = aws_instance.app_server.id
}

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
  # description = "Public IP address of the EC2 instance"
}

output "instance_arn" {
  value = aws_instance.app_server.arn
}