variable "dynamodb_name" {
    type = string
    description = "The dynamodb name."
}

variable "partition_key" {
    type = string 
    description = "the name of the partition key. MUST be 'LockID' and it is case sensitive."
    default = "LockID"
}

variable "bucket_name" {
    type = string 
    description = "The name of the bucket."
}