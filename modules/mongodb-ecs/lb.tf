resource "aws_lb" "mongo_nlb" {
  name                       = "${var.cluster_name}-mongo-nlb-${var.environment}"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = var.subnets
  enable_deletion_protection = false

  tags = {
    Name = "mongo-nlb"
  }
}

resource "aws_lb_target_group" "mongo_tg" {
  name     = "${var.cluster_name}-mongo-tg-${var.environment}"
  port     = 27017
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip"

}

resource "aws_lb_listener" "mongo_lb_listener" {
  load_balancer_arn = aws_lb.mongo_nlb.arn
  port              = 27017
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mongo_tg.arn
  }
}
