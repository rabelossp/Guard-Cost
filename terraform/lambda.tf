resource "aws_iam_role" "lambda_exec" {
name = "lambda-stop-role"
assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [{
Action = "sts:AssumeRole"
Principal = { Service = "lambda.amazonaws.com" }
Effect = "Allow"
}]
})
}


resource "aws_iam_role_policy_attachment" "lambda_basic" {
role = aws_iam_role.lambda_exec.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_iam_role_policy_attachment" "lambda_stop_ec2" {
role = aws_iam_role.lambda_exec.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}


resource "aws_lambda_function" "stop_resources" {
function_name = "stop-resources"
role = aws_iam_role.lambda_exec.arn
handler = "handler.lambda_handler"
runtime = "python3.12"


filename = "${path.module}/../lambda/lambda.zip"
source_code_hash = filebase64sha256("${path.module}/../lambda/lambda.zip")
}