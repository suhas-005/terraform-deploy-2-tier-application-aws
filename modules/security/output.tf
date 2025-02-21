output "ALB_SG_ID" {
  value = aws_security_group.alb_sg.id
}

output "EC2_SG_ID" {
  value = aws_security_group.ec2_sg.id
}

output "DB_SG_ID" {
  value = aws_security_group.db_sg.id
}