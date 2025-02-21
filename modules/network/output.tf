output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUB_SUB_1_ID" {
  value = aws_subnet.pub-sub-1.id
}
output "PUB_SUB_2_ID" {
  value = aws_subnet.pub-sub-2.id
}

output "PRIV_SUB_1_ID" {
  value = aws_subnet.priv-sub-1.id
}

output "PRIV_SUB_2_ID" {
    value = aws_subnet.priv-sub-2.id 
}

output "IGW_ID" {
    value = aws_internet_gateway.igw
}