variable "aws_region" {
  description = "AWS region (ex.: us-east-1)"
  type        = string
}

variable "project" {
  description = "Short project name for naming"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "lab"
}

variable "state_bucket_name" {
  description = "Optional fixed S3 bucket name"
  type        = string
  default     = null
}

variable "dynamodb_table_name" {
  description = "Optional fixed DynamoDB table name"
  type        = string
  default     = null
}
