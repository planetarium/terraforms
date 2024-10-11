resource "aws_launch_template" "mimir_lt" {
  name_prefix   = "${local.kebab_case_prefix}-mimir-instance-"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = "t4g.small"

  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.mimir_sg.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_instance_profile.arn
  }

  monitoring { enabled = true }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.kebab_case_prefix}-mimir-instance"
    }
  }

  instance_market_options {
    market_type = "spot"
  }

  user_data = base64encode(
    templatefile(
      "${path.module}/user-data/user_data.sh",
      {
        ecs_cluster_name = var.cluster_name
      }
    )
  )
}

resource "aws_autoscaling_group" "mimir_asg" {
  name_prefix               = "${local.kebab_case_prefix}-mimir-instance-"
  vpc_zone_identifier       = local.private_subnet_ids
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 0
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.mimir_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.kebab_case_prefix}-mimir-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
