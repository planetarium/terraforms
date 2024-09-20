resource "aws_lb" "nlb" {
  name                       = "${local.kebab_case_prefix}-ecs-nlb"
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = var.public_subnets
  enable_deletion_protection = false

  tags = {
    Name = "${local.kebab_case_prefix}-ecs-nlb"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${local.kebab_case_prefix}-ecs-tg"
  port        = 27017
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 27017
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
