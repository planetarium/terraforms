resource "aws_security_group" "alb_sg" {
  name        = "${local.kebab_case_prefix}-ecs-alb-sg"
  description = "Security group for ninecub"
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

resource "aws_security_group" "service_sg" {
  name        = "${local.kebab_case_prefix}-ecs-service-sg"
  description = "Security group for ninecub"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "${local.kebab_case_prefix}-ecs-service-sg"
  }
}
