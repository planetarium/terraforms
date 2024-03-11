resource "aws_security_group" "sg" {
  name        = "${var.cluster_name}-ninecubs-sg-${var.environment}"
  description = "Security group for ninecubs"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ninecubs-sg-${var.environment}"
  }
}
