output "RDS_PRIMARY_HOST" {
  value = aws_db_instance.rds_primary.address
}

output "RDS_REPLICA_HOST" {
  value = aws_db_instance.rds_replica.address
}

output "RDS_ENDPOINT" {
  value = aws_db_instance.rds_primary.endpoint
}

output "RDS_DB" {
  value = aws_db_instance.rds_primary.db_name
}