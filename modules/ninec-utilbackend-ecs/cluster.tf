resource "aws_ecs_cluster" "ecs_cluster" {
  count = var.create_cluster ? 1 : 0
  name  = var.cluster_name
}
