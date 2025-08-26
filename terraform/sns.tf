# SNS Topic para alertas de custo
resource "aws_sns_topic" "cost_alerts" {
  name = "guard-cost-alerts"

  tags = {
    Name        = "Guard Cost Alerts Topic"
    Environment = "production"
    Project     = "guard-cost"
  }
}

# Subscription para email (opcional - descomente se quiser receber emails)
# resource "aws_sns_topic_subscription" "email_alerts" {
#   topic_arn = aws_sns_topic.cost_alerts.arn
#   protocol  = "email"
#   endpoint  = "seu-email@example.com"  # Substitua pelo seu email
# }

# Output para usar em outros módulos
output "sns_topic_arn" {
  description = "ARN do SNS Topic para alertas de custo"
  value       = aws_sns_topic.cost_alerts.arn
}