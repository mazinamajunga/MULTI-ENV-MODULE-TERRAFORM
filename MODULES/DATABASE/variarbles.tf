
variable "subnet_group" {
  type        = list(string)
  description = "The list of subnet IDs for the subnet group."
}

variable "subnet_group_name" {
  type        = string
  description = "The name of the subnet group."
}

variable "username" {
  type = string 
  sensitive = true 
  description = "The master useername of the database."
}

variable "password" {
  type = string
  sensitive = true
  description = "The master password of the database. May show up in plain text in the log"
}

variable "vpc_id"{
    type = string
    description = "the id of the vpc"     
}

variable "asg_security_group_id" {
  type = string
  description = "The Id of the security group of the ASG"
  
}

variable "database_security_group_name" {
  type = string 
  description = "The name of the database security group."
}

variable "database_security_group_description" {
  type = string 
  description = "The description of the database security group."
  default = "Allow traffic to the database from the business tier."
}

variable "database_port" {
  type = number
  description = "The port the database listens to."
}

variable "database_security_group_tags" {
  type = string
  description = "The tag of the database security group."
}

variable "identifier" {
  type = string
  description = "The name of the RDS instance"
}  
 
variable "allocated_storage" {
  type = number
  description = "Size of the storage in GB"
} 

variable "storage_type" {
  type = string
  description = "The Size of the storage in GB"
  default = "gp2"
} 

variable "engine" {
  type = string
  description = "The type of engine of the database"
} 

variable "engine_version" {
  type = string
  description = "The engine version of the database"
} 

variable "instance_class" {
  type = string
  description = "The compute and memory capacity of the DB instance"
} 

variable "db_name" {
  type = string
  description = "The name of the database to create when the DB instance is created."
} 

variable "replica_identifier" {
  type = string
  description = "The name of the Replica instance"
} 

variable "replica_instance_class" {
  type = string
  description = "The compute and memory capacity of the Replica instance"
} 