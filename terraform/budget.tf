resource "aws_budgets_budget" "monthly" {
name = "cost-guard"
budget_type = "COST"
limit_amount = "0.01"
limit_unit = "USD"
time_unit = "MONTHLY"


notification {
comparison_operator = "GREATER_THAN"
threshold = 0.01
threshold_type = "ABSOLUTE_VALUE"
notification_type = "FORECASTED"
subscriber_sns_topic_arns = [aws_sns_topic.alerts.arn]
}
}


resource "aws_sns_topic" "alerts" {
name = "cost-guard-alerts"
}


resource "aws_sns_topic_subscription" "lambda_sub" {
topic_arn = aws_sns_topic.alerts.arn
protocol = "lambda"
endpoint = aws_lambda_function.stop_resources.arn
}


resource "aws_lambda_permission" "sns_invoke" {
statement_id = "AllowExecutionFromSNS"
action = "lambda:InvokeFunction"
function_name = aws_lambda_function.stop_resources.function_name
principal = "sns.amazonaws.com"
source_arn = aws_sns_topic.alerts.arn
}