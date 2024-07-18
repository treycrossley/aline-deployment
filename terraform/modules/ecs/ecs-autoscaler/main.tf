resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_name  # Specify the name for your key pair
  public_key = file(var.public_key_path)  # Specify the public key file path
}

data "aws_ami" "latest_ecs" {
most_recent = true
owners = ["591542846629"] # AWS

  filter {
      name   = "name"
      values = ["*amazon-ecs-optimized"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }  
}


resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-profile"

  role = var.instance_role_name
}

resource "aws_launch_template" "ecs_instance" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = data.aws_ami.latest_ecs.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2_key_pair.key_name

  network_interfaces {
    security_groups = var.security_groups
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
              EOF
  )

   iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_instances" {
  name                 = var.autoscaling_group_name
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnets
  launch_template {
    id      = aws_launch_template.ecs_instance.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }
}
