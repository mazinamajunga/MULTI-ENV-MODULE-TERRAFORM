
output "mysql_instance_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}

output "mysql_instance_arn" {
  value = aws_db_instance.mysql_db.arn
}

output "mysql_replica_endpoint" {
  value = aws_db_instance.test_replica.endpoint
}

output "mysql_replica_arn" {
  value = aws_db_instance.test_replica.arn
}

output "database_security_group_id" {
  value = aws_security_group.database_security_group.id
}



