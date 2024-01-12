
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.0"
    }
  }
  
  # THE RECOMMENDATION IS TO CREATE THE BUCKET AND THE DYNAMODB TABLE WITH TERRAFORM (not manually)
  # FIRST AND THEN APPLY THE OTHER CONFIGURATION.
  backend "s3" {
    # State file storage
    bucket = "myuseast2backend"   #var.s3_bucket  # The name of the bucket
    key    = "terraform/dev/tfstate"     # var.s3_key  # The path to the "tfstate-file" in the bucket.
    /*
    In this case, Terraform will successively create these folder (terraform/ and dev/) and 
    finally create the file "tfstate" following the path given above. 
    The file can have any name and the key does not have to be a path, but anticipating 
    that we might have many remote files from different resources in the bucket, 
    it is better to have a folder system with files in them.
    */
    region = "us-east-2"  # var.aws_region      # Region where the bucket is located.
    # Name of DynamoDB Table to use for STATE LOCKING and CONSISTENCY. 
    # The table must have a partition key named LockID with type of String
    dynamodb_table = "my-state-table_us_east_2"  # var.dynamodb_table   
  }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}







