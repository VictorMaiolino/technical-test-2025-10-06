data "aws_caller_identity" "current" {}

locals {
  normalized_project = lower(replace(var.project, "/[^a-zA-Z0-9-]/", "-"))
  account_id         = data.aws_caller_identity.current.account_id

  default_bucket = "tfstate-${local.normalized_project}-${local.account_id}-${var.aws_region}"
  state_bucket   = coalesce(var.state_bucket_name, local.default_bucket)

  default_table  = "tfstate-lock-${local.normalized_project}"
  dynamodb_table = coalesce(var.dynamodb_table_name, local.default_table)

  common_tags = {
    Project   = var.project
    Env       = var.environment
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_bucket" "state" {
  bucket = local.state_bucket
  tags   = local.common_tags
}

resource "aws_s3_bucket_ownership_controls" "state" {
  bucket = aws_s3_bucket.state.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state" {
  bucket = aws_s3_bucket.state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket                  = aws_s3_bucket.state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "enforce_tls" {
  bucket = aws_s3_bucket.state.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "DenyInsecureTransport",
      Effect    = "Deny",
      Principal = "*",
      Action    = "s3:*",
      Resource = [
        aws_s3_bucket.state.arn,
        "${aws_s3_bucket.state.arn}/*"
      ],
      Condition = {
        Bool = { "aws:SecureTransport" = "false" }
      }
    }]
  })
}

resource "aws_dynamodb_table" "lock" {
  name         = local.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.common_tags
}
