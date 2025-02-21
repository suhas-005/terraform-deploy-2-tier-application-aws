output "INSTANCE_1_PUBLIC_IP" {
  value = aws_instance.server_1.public_ip
}

output "INSTANCE_2_PUBLIC_IP" {
  value = aws_instance.server_2.public_ip
}

output "INSTANCE_1_ID" {
  value = aws_instance.server_1.id
}

output "INSTANCE_2_ID" {
  value = aws_instance.server_2.id
}
