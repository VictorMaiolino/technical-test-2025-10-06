output "state_bucket" {
  description = "S3 bucket (Terraform state)"
  value       = aws_s3_bucket.state.bucket
}

output "dynamodb_table" {
  description = "DynamoDB table (state lock)"
  value       = aws_dynamodb_table.lock.name
}
