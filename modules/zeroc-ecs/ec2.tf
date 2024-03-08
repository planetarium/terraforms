resource "aws_launch_template" "zeroc_lt" {
  name_prefix   = "${var.cluster_name}-zeroc-ecs-instance-"
  image_id      = data.aws_ssm_parameter.ecs_ami.value
  instance_type = var.instance_type

  key_name               = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.zeroc_ecs_instances_sg.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_instance_profile.arn
  }

  monitoring { enabled = true }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 50
      volume_type           = "gp3"
      delete_on_termination = false
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-zeroc-ecs-instance"
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

resource "aws_autoscaling_group" "zeroc_asg" {
  name_prefix               = "${var.cluster_name}-zeroc-ecs-instance-"
  vpc_zone_identifier       = var.subnets
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 0
  health_check_type         = "EC2"
  protect_from_scale_in     = false

  launch_template {
    id      = aws_launch_template.zeroc_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-zeroc-asg"
    propagate_at_launch = true
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
  key_name   = "${var.cluster_name}-zeroc-key"
  public_key = tls_private_key.private_key.public_key_openssh
}

# resource "local_file" "cloud_pem" { 
#   filename = "${path.module}/cloudtls.pem"
#   content = tls_private_key.private_key.private_key_pem
# }
