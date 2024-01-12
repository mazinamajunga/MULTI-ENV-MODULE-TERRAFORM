
resource "aws_db_subnet_group" "dev_env_subnet_group" {
  name       = var.subnet_group_name  # name of the subnet group
  subnet_ids = var.subnet_group
}

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
  storage_encrypted  = true
  deletion_protection = true
  backup_retention_period     = 7
#   final_snapshot_identifier = "mysql-db-final-snapshot"  # Provide a unique identifier for the final snapshot
  skip_final_snapshot         = true
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
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
  deletion_protection = true
}

resource "aws_security_group" "database_security_group" {
  name        = var.database_security_group_name 
  description = var.database_security_group_description # "Allow traffic to the database from the business tier."
  vpc_id      = var.vpc_id 

  ingress {
    description      = "Allow access from business tier"
    from_port        = var.database_port 
    to_port          = var.database_port   
    protocol         = "tcp"
    cidr_blocks = [var.asg_security_group_id]
    # cidr_blocks      = [
    #   for i in range(3, 6):
    #     cidrsubnet(aws_vpc.my_vpc.cidr_block, 8, i)
    # ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] # tfsec:ignore:aws-ec2-no-public-egress-sgr
  }

  tags = {
    Name = var.database_security_group_tags 
  }
}


