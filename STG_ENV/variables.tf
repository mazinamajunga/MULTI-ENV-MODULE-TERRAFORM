variable "aws_region" {
    type = string
    description = "The region to host the infrastructure."
}

variable "vpc_cidr" {
    type = string 
    description = "the cidr of the vpc"
}

variable "image_id" {
    type = string 
    description = "the image to be used with ASG"       # region pecific
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