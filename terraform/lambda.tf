# Data source para criar o arquivo ZIP automaticamente
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda"
  output_path = "${path.module}/lambda.zip"
}

# IAM Role para a Lambda
resource "aws_iam_role" "lambda_role" {
  name = "guard-cost-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "guard-cost-lambda-role"
    Environment = "production"
    Project     = "guard-cost"
  }
}

# IAM Policy para a Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name = "guard-cost-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances",
          "rds:DescribeDBInstances",
          "rds:StopDBInstance",
          "ecs:DescribeClusters",
          "ecs:DescribeServices",
          "ecs:UpdateService"
        ]
        Resource = "*"
      }
    ]
  })
}

# Função Lambda
resource "aws_lambda_function" "stop_resources" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "guard-cost-stop-resources"
  role          = aws_iam_role.lambda_role.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.9"
  timeout       = 60

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      ENVIRONMENT = "production"
    }
  }

  tags = {
    Name        = "guard-cost-stop-resources"
    Environment = "production"
    Project     = "guard-cost"
  }
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/guard-cost-stop-resources"
  retention_in_days = 7

  tags = {
    Name        = "guard-cost-lambda-logs"
    Environment = "production"
    Project     = "guard-cost"
  }
}