# MODULE ASG VARIABLE

variable "image_id" {
    type = string
    description = "image to use with launch template"           
}

variable "instance_type" {
    type = string
    description = "type of instances to use with launch template"   
}

variable "key_name" {
    type = string
    description = "preexisting key to be used in LT"      
}

variable "availability_zones" {
    type = list(string)                   
    description = "List of one or more availability zones for the group"      
}

variable "availability_zone" {
    type = string
    description = "Instances AZ"
    default = "us-east-1a"         
}

variable "name"{
    type = string
    description = "name of the LT"   
     default = "my_LT" 
}

variable "monitoring" {
    type = bool
    description = "enable detailed monitoring"         
    default = true
}

variable "public_ip_address" {
    type = bool
    description = "associate instance with a public ip address"        
    default = true
}

variable "resource_type"{
    type = string
    description = "The type of resource to tag"        
    default = "instance"
}

variable "max_size"{
    type = number
    description = "the max number of instance to be created by ASG"   
}

variable "min_size"{
    type = number
    description = "the min number of instance available at all time"     
}

variable "desired_capacity"{
    type = number
    description = "the number of instance desired"    
}

variable "ssh_ingress_port" {
  type = number
  description = "the port to which ssh listen to"
#   default = 22
}

variable "http_ingress_port" {
  type = number
  description = "the port to which http listen to"
#   default = 80
}

variable "protocol" {
  type = string
  description = "the protocol used by the SG"
  default = "tcp"
}

variable "internet_cidr" {
  type = string
  description = "the generic cidr"
  default = "0.0.0.0/0"
}

variable "vpc_id"{
    type = string
    description = "the id of the vpc"     
}

variable "subnet_id" {
    type = string
    description = "The VPC Subnet ID to associate with the network interface."          
}

variable "zone_identifier" {
    type = list(string) 
    description = "List of subnet IDs to launch resources in."       
}