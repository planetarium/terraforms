resource "aws_lb" "mongo_alb" {
  name               = "${var.cluster_name}-mongo-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.mongo_sg.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Name = "mongo-alb"
  }
}

resource "aws_lb_target_group" "mongo_tg" {
  name     = "${var.cluster_name}-mongo-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/"
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_lb_listener" "mongo_lb_listener" {
  load_balancer_arn = aws_lb.mongo_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mongo_tg.arn
  }
}
