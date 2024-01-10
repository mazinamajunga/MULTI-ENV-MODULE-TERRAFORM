variable "aws_region" {
    type = string
    description = "The region to host the infrastructure."
}

# variable "dynamodb_table" {
#   type = string 
#   description = "The name of the dynamodb table"
# }

# variable "s3_bucket" {
#   description = "Name of the S3 bucket for Terraform state"
#   type = string 
# }

# variable "s3_key" {
#   description = "Path within the S3 bucket for Terraform state"
#   type = string 
# }

variable "vpc_cidr" {
    type = string 
    description = "the cidr of the vpc"
}

variable "image_id" {
    type = string 
    description = "the image to be used with ASG"      
}

variable "instance_type" {
    type = string 
    description = "the type of instance to be used"
}

variable "key_name" {
    type = string 
    description = "the key-pair for that region"
}

variable "my_count" {
    type = string 
    description = "The number of subnets to create" 
}

variable "private_count" {
    type = string 
    description = "the number of private rtb to be created"   
}

variable "priv_assoc_count" {
    type = string 
    description = "the number of private/database rtb association to be created"           
}

variable "ssh_port" {
    type = number
    description = "the port to which ssh listen to"         
}

variable "http_port" {
    type = number
    description = "the port to which http listen to"        
}


variable "identifier" {
  type = string
  description = "The name of the RDS instance"
}  

variable "allocated_storage" {
  type = number
  description = "Size of the storage in GB"
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

variable "subnet_group_name" {
  type        = string
  description = "The name of the subnet group."
}


