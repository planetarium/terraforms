resource "aws_security_group" "sg" {
  name        = "${local.kebab_case_prefix}-ecs-alb-sg"
  description = "Security group for zeroc"
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
    Name = "${local.kebab_case_prefix}-ecs-sg"
  }
}
