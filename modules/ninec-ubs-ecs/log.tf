resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.cluster_name}-ninecubs-${var.environment}"
  retention_in_days = 30
}
