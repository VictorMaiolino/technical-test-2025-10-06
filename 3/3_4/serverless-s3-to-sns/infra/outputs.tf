output "sns_topic_arn" {
  value       = aws_sns_topic.notify.arn
  description = "SNS Topic ARN (notifications)"
}

output "lambda_function_name" {
  value       = aws_lambda_function.fn.function_name
  description = "Lambda function name"
}
