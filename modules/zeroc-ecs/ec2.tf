resource "aws_launch_template" "zeroc_lt" {
  name_prefix   = "zeroc-template"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = var.instance_type

  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.zeroc_sg.id]

  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-zeroc-ecs-instance"
    }
  }

  user_data = base64encode(templatefile("${path.module}/user-data/user_data.sh", { ecs_cluster_name = var.cluster_name }))
}

resource "aws_autoscaling_group" "zeroc_asg" {
  vpc_zone_identifier = var.subnets
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1

  launch_template {
    id      = aws_launch_template.zeroc_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.cluster_name}-zeroc-template"
  public_key = tls_private_key.private_key.public_key_openssh
}
