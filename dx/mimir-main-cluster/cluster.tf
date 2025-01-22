resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name

  tags = {
    Name    = var.cluster_name,
    Owner   = "jiwon",
    Service = "mimir",
    Team    = "game"
  }
}

resource "aws_ecs_capacity_provider" "mimir_capacity_provider" {
  name = "${local.kebab_case_prefix}-mimir-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.mimir_asg.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 4
      minimum_scaling_step_size = 2
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_capacity_provider" "mimir_worker_capacity_provider" {
  name = "${local.kebab_case_prefix}-mimir-worker-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.mimir_worker_asg.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 2
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_capacity_providers" {
  cluster_name = var.cluster_name

  capacity_providers = [
    aws_ecs_capacity_provider.mimir_capacity_provider.name,
    aws_ecs_capacity_provider.mimir_worker_capacity_provider.name
  ]
}
