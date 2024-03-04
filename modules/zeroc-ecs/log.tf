resource "aws_cloudwatch_log_group" "zeroc_log_group" {
  name = "/ecs/${var.cluster_name}-zeroc-${var.environment}"
  retention_in_days = 30
}
