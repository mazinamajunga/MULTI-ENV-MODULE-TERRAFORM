variable "vpc_cidr" {
  type = string
  description = "the CIDR of the vpc"   
}

variable "dns_support" {
  type = bool
  description = "DNS support in the VPC"   
  default = true
}

variable "dns_hostnames" {
  type = bool
  description = "DNS hostnames in the VPC"    
  default = true
}

variable "my_count" {
  type = number
  description = "number of subnets to create"       
}

variable "internet_cidr" {
  type = string
  description = "the generic cidr"
  default = "0.0.0.0/0"             
}

variable "private_count" {
  type = number
  description = "the number of private rtb to be created"       
}

variable "priv_assoc_count" {
  type = number
  description = "the number of private/database rtb association to be created"           
}


