variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "lambda_name" {
  type        = string
  description = "Lambda function name"
  default     = "s3-to-sns-handler"
}

variable "bucket_name" {
  type        = string
  description = "Existing S3 bucket name to attach notifications"
}
