
output "db_instance_arn" {
    description = "The ARN of the RDS instance"
    value = module.database.mysql_instance_arn
}

output "db_instance_endpoint" {
  description = " The endpoint of the database"
  value = module.database.mysql_instance_endpoint
}

output "db_replica_arn" {
    description = "The ARN of the RDS instance"
    value = module.database.mysql_replica_arn
}
output "db_replica_endpoint" {
  description = " The endpoint of the database"
  value = module.database.mysql_replica_endpoint
}
