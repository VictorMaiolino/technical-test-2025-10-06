terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws     = { source = "hashicorp/aws",     version = ">= 5.0" }
    archive = { source = "hashicorp/archive", version = ">= 2.4" }
  }
}

provider "aws" {
  region = var.aws_region
}

# SNS para notificações
resource "aws_sns_topic" "notify" {
  name = "${var.lambda_name}-topic"
}

# IAM Role para a Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}

# Política mínima: logs + publicar no SNS
resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.lambda_name}-policy"
  description = "Allow CloudWatch logs and publish to SNS"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow",
        Action = ["sns:Publish"],
        Resource = aws_sns_topic.notify.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Empacotar Lambda a partir do diretório ../lambda
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda"
  output_path = "${path.module}/../lambda.zip"
}

# Função Lambda
resource "aws_lambda_function" "fn" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "handler.handler"
  runtime       = "python3.11"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      TOPIC_ARN = aws_sns_topic.notify.arn
    }
  }
}

# Permitir que o S3 invoque a Lambda
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fn.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.bucket_name}"
}

# Notificação do S3 para a Lambda (ObjectCreated)
resource "aws_s3_bucket_notification" "bucket_notify" {
  bucket = var.bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.fn.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}

output "sns_topic_arn" {
  value       = aws_sns_topic.notify.arn
  description = "SNS Topic ARN (notifications)"
}

output "lambda_function_name" {
  value       = aws_lambda_function.fn.function_name
  description = "Lambda function name"
}
