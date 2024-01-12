
output "vpc_id" {
    value = module.vpc.vpc_id
    description = "the vpc id"
}

output "public_subnets_id" {
    value       = module.vpc.public_subnets_id  # Extracting the list of public subnets Ids
    description = "the list of public subnet ids"
}

output "private_subnets_id" {
    value       = module.vpc.private_subnets_id   # Extracting the list of private subnets Ids
    description = "the list of private subnet ids"
}

output "database_subnets_id" {
    value       = module.vpc.database_subnets_id   # Extracting the list of database subnets Ids
    description = "the list of database subnet ids"
}

output "availability_zone" {
    value = module.vpc.availability_zone
    description = "the list of availability_zone"
}

output "public_subnets_cidr" {
    value =  module.vpc.public_subnets_cidr
    description = "the list of public subnet cidrs"
}

output "private_subnets_cidr" {
    value =  module.vpc.private_subnets_cidr
    description = "the list of private subnet cidrs"
}

output "database_subnets_cidr" {
    value =  module.vpc.database_subnets_cidr
    description = "the list of database subnet cidrs"
}

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

