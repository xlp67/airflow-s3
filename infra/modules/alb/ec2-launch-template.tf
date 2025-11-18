resource "aws_launch_template" "ec2_launch_template" {
  name_prefix   = "launch_template"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = "key-pair"
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile {
    name = "ec2-role-instance-profile"
  }

  user_data = filebase64("${path.module}/ecs.sh")
}


resource "aws_key_pair" "key-pair" {
  key_name   = "key-pair"
  public_key = file("${path.module}/id_rsa.pub")
}