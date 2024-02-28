module "ecs_cluster" {
  source = "../modules/ecs-cluster"
  cluster_name = "mongodb-cluster"
}

module "mongodb_service" {
  source              = "../modules/ecs-service"
  service_name        = "mongodb-service"
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = aws_ecs_task_definition.mongodb.arn
  desired_count       = 1
  launch_type         = "FARGATE"
  subnets             = var.subnets
  security_groups     = var.security_groups
  assign_public_ip    = true
}

resource "aws_ecs_task_definition" "mongodb" {
  family                = "mongodb"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "256"
  memory                = "512"
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = "mongodb",
      image     = "mongo",
      cpu       = 256,
      memory    = 512,
      essential = true,
      portMappings = [
        {
          containerPort = 27017,
          hostPort      = 27017,
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
