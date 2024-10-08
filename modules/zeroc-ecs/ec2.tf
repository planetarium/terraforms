resource "aws_launch_template" "lt" {
  name_prefix   = "${local.kebab_case_prefix}-ecs-instance-"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = var.instance_type

  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_instance_profile.arn
  }

  monitoring { enabled = true }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 50
      volume_type = "gp3"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.kebab_case_prefix}-ecs-instance"
      Team = var.tags.Team
    }
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

resource "aws_autoscaling_group" "asg" {
  name_prefix               = "${local.kebab_case_prefix}-ecs-instance-"
  vpc_zone_identifier       = var.subnets
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 0
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.kebab_case_prefix}-ecs-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/arm64/recommended/image_id"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${local.kebab_case_prefix}-ecs-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

# resource "local_file" "cloud_pem" { 
#   filename = "${path.module}/cloudtls.pem"
#   content = tls_private_key.private_key.private_key_pem
# }
