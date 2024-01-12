
resource "aws_s3_bucket" "my_tfsec_bucket" {
  bucket = var.bucket_name   # "my-tfsec-bucket"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.my_tfsec_bucket.id # Specifies the S3 bucket to apply the public access block settings to.
  block_public_acls       = true                             # Blocks public access via ACLs (Access Control Lists).
  block_public_policy     = true                             # Blocks public access via bucket policies.
  ignore_public_acls      = true                             # Ignores public ACLs, making sure they don't grant public access.
  restrict_public_buckets = true                             # Restricts all public access to the bucket.
}

resource "aws_kms_key" "my_tfsec_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# Create the alias for the kms key.
resource "aws_kms_alias" "my_tfsec_key" {
  name          = "alias/my_tfsec_key"    # Must follow this syntax.
  target_key_id = aws_kms_key.my_tfsec_key.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfsec_bucket_encryption" {
  bucket = aws_s3_bucket.my_tfsec_bucket.id # Specifies the S3 bucket to apply server-side encryption settings to.
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.my_tfsec_key.arn # Specifies the KMS master key to use for encryption.
      sse_algorithm     = "aws:kms"   # Specifies that the encryption algorithm to use is AWS Key Management Service (KMS).
    }
  }
}

resource "aws_s3_bucket_logging" "tfsec_logging_bucket" {
  bucket        = aws_s3_bucket.my_tfsec_bucket.id
  target_bucket = "mstacwebsti" # Referencing the logging bucket.
  target_prefix = "log/"
}

resource "aws_s3_bucket_versioning" "tfsec_bucket_versioning" {
  bucket = aws_s3_bucket.my_tfsec_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "dynamo_db_kms" {
    enable_key_rotation = true
    description             = "This key is used to encrypt the dynamoDB tables."
 }

resource "aws_kms_alias" "dynamo_db_kms" {
  name          = "alias/dynamo_db_kms"
  target_key_id = aws_kms_key.dynamo_db_kms.key_id
}

resource "aws_dynamodb_table" "state_lock_table" {
  name           = var.dynamodb_name  #"my-state-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.partition_key  # "LockID"
  
  server_side_encryption {
    enabled = true // enabled server side encryption
    kms_key_arn = aws_kms_key.dynamo_db_kms.key_id
  }

  attribute {
    name = var.partition_key  # "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }
}

