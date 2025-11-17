resource "aws_launch_template" "ec2_launch_template" {
  name_prefix   = "${var.launch_template_name}"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = "key-pair"
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile {
    name = "ec2-role-instance-profile"
  }
  tags_especications {
    resource_type = "instance"
    tags = {
      Name = "${var.launch_template_name}-instance"
      To = "ECS"
    }
  }
  user_data = filebase64("${path.module}/ecs.sh")
}

