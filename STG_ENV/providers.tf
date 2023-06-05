
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.0"
    }
  }
  backend "s3" {
    # State file storage
    bucket = "mynewestfirstbucket"  # The name of the bucket
    key    = "terraform/stg/tfstate"   # The path to the "tfstate-file" in the bucket.
    /*
    In this case, Terraform will successively create these folder (terraform/ and remote-state/) and 
    finally create the file "terraform.tfstate" following the path given below. 
    The file can have any name and the key does not have to be a path, but anticipating 
    that we might have many remote files from different resources in the bucket, 
    it is better to have a folder system with files in them
    */
    region = "us-east-1"      # Region where the bucket is created.
    # Name of DynamoDB Table to use for STATE LOCKING and CONSISTENCY. The table must have a partition key named LockID with type of String
    dynamodb_table = "my-state-table"  
  }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}