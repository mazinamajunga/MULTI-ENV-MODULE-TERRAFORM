
variable "subnet_group" {
  type        = list(string)
  description = "The list of subnet IDs for the subnet group."
}

variable "subnet_group_name" {
  type        = string
  description = "The name of the subnet group."
}

# variable "secret" {
#   type        = string
#   description = "Name of the secret in AWS KMS."
# }

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

# variable "payload" {
#   type        = string
#   sensitive   = true
#   description = "Base64-encoded payload to be decrypted by KMS."
# }

# variable "payload" {
#     type = string 
#     sensitive = true
#     description = "Value return from KMS encrypt operation."
#     # default = file("C:\\Users\\patri\\OneDrive\\Documents\\Devops\\ESSAI\\db_creds.yml.encrypted") # Full path to the encrypted file.
# }

# variable "secret" {
#     type = string
#     description = "The name of the secret or unencrypted file(no extension) with the credentials of the database."
#     default = "db_creds"
# }

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