
resource "aws_db_subnet_group" "dev_env_subnet_group" {
  name       = var.subnet_group_name  # name of the subnet group
  subnet_ids = var.subnet_group
}

# data "aws_kms_secrets" "db_creds" {  # Using aws_kms_secrets data source to decrypt a secret named "db-creds" from an encrypted YAML file.
#     secret {
#         name = var.secret #  "db-creds"  # name of the unencryted file contsining the credentials without extension.
#         # payload = "AQICAHjyd+7N6Dg25O3/w89/WnJ1x2ajOBjIfa/jzqhREprLXQHRQjWppXdTigSgqwS6ZcdSAAABbjCCAWoGCSqGSIb3DQEHBqCCAVswggFXAgEAMIIBUAYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAy+TzhkXBM50KTgcJECARCAggEhJbaaHrCZgkk39R+SnbNDkUyvQU3abFpifnS233J6hbUIMoYmGCEIiVX1dEJIN8lGon3myMpf5gt9ejr/poW9JWIew51UMLgC27F/xjoyVhhOlwfIbvILN2AgI+6+ne/X9baWcL3G0i02k+nv9I1jt+6WjQ/rZUktQn6c5IS0dH1TXCa1CY0mxHxMKK1Pvw9FO5+A4FZQsfAyErOm1q3Ofn8K95MuvWGN2ry/hfP+kf4Luwx2HcH6d9iU4GfBRcLdb+Tn/UXsOsw5YQYWMNQ2XGQcP52m+iWMSl1IWiEJla7Pu5aWm729BmSOsreHndzUJ+SvVYpjVFmtbphSBWjM29XHsP3uRBL8nxDtrFdyJ7YWlUfbSu4eRe6QJGw8RyUGxg=="
#         # payload = "AQICAHgnFtUhrofVdMAVRUctVbHCMtVxEzC5RhIF+grjnD8IYgEn01lMGXO3FL58awaKWt23AAAAlzCBlAYJKoZIhvcNAQcGoIGGMIGDAgEAMH4GCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMyWQdC5OZlBChq0xFAgEQgFHbFHQaItr82bE9EzL6kB5nGQY69RXs0zpClDuk8yJOiiqZ/pQgya1oXMB9W8BmBnaC7YVJ/tj5ZuvKa7gkQVZLa6abDj6L5t7Ads5Y+Jx/sNI="   
#         payload = var.payload # Assigning the content of the encrypted file as the payload for the aws_kms_secrets data source.
#     }
# }

# locals {
#     # "yamldecode is a terraform function use to convert yaml format into terraform format."
#     db_creds = yamldecode(data.aws_kms_secrets.db_creds.plaintext["db_creds"])
# }

resource "aws_db_instance" "mysql_db" {
  identifier             = var.identifier # "mysql-db-instance"  # The name of the RDS instance
  allocated_storage      = var.allocated_storage  # 20  # Size of the storage in GB
  storage_type           = var.storage_type  #  "gp2"  # General Purpose SSD storage type
  engine                 = var.engine #  "mysql"
  engine_version         = var.engine_version #  "8.0"
  instance_class         = var.instance_class # "db.t2.micro"  # Change this to the desired instance type
  db_name                   = var.db_name # "mydatabase"  # name of the database to create when the DB instance is created.
  username = var.username                                  # local.db_creds.username       # Fetching the decrypted password.
  password = var.password                                  # local.db_creds.password         # Fetching the decripted password
  db_subnet_group_name   = aws_db_subnet_group.dev_env_subnet_group.name  # name of the subnet group.
  multi_az = true
  backup_retention_period     = 7
#   final_snapshot_identifier = "mysql-db-final-snapshot"  # Provide a unique identifier for the final snapshot
  skip_final_snapshot         = true
}

resource "aws_db_instance" "test_replica" {
  replicate_source_db         = aws_db_instance.mysql_db.identifier  # Specify the identifier of the source (primary) DB instance from which the read replica is created.
  # replica_mode                = "mounted"  # Specify that the replica is mmounted
  backup_retention_period     = 7
  identifier                  = var.replica_identifier # "test-replica" #  The name of the RDS instance
  instance_class              = var.replica_instance_class # "db.t2.micro"  # Specify the compute and memory capacity of the DB instance.
#   kms_key_id                  = data.aws_kms_key.by_id.arn
  multi_az                    = true # Custom for Oracle does not support multi-az
  skip_final_snapshot         = true 
}



