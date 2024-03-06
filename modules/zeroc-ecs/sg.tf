resource "aws_security_group" "zeroc_alb_sg" {
  name        = "${var.cluster_name}-zeroc-alb-sg-${var.environment}"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zeroc-alb-sg-${var.environment}"
  }
}

resource "aws_security_group" "zeroc_ecs_instances_sg" {
  name        = "${var.cluster_name}-zeroc-ecs-instances-sg-${var.environment}"
  description = "Security group for ECS instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5009
    to_port         = 5009
    protocol        = "tcp"
    security_groups = [aws_security_group.zeroc_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-instances-sg-${var.environment}"
  }
}
