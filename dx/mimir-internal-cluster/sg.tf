resource "aws_security_group" "mimir_worker_sg" {
  name        = "${local.kebab_case_prefix}-ecs-cluster-mimir-worker-sg"
  description = "Security group for mimir-worker"
  vpc_id      = local.vpc_id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.docdb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.kebab_case_prefix}-ecs-cluster-mimir-worker-sg"
  }
}

resource "aws_security_group" "mimir_sg" {
  name        = "${local.kebab_case_prefix}-ecs-cluster-mimir-sg"
  description = "Security group for mimir"
  vpc_id      = local.vpc_id

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
    Name = "${local.kebab_case_prefix}-ecs-cluster-mimir-sg"
  }
}
