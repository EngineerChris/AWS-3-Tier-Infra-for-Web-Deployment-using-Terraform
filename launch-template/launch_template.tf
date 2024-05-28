resource "aws_launch_template" "launch_template" {
  name                    = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-launch-template"
  description             = "My EC2 Launch Template"
  instance_type          = var.instance_type
  image_id               = var.image_id  # Specify the AMI ID for your desired Amazon Machine Image
  vpc_security_group_ids = [var.public_sg,]  # Specify your security group IDs
  user_data              = base64encode(file("scripts/static-website-user-data.sh"))


  tag_specifications {
    resource_type = "instance"
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-instance"
  }) 
}
  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity     = 4
  max_size             = 6
  min_size             = 2
  force_delete         = true
  vpc_zone_identifier = [var.public_subnet1, var.public_subnet2]  # Replace with your subnet IDs
 
  launch_template {
    id = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  target_group_arns = var.target_group_arns
}








# Application Web server Launch Template and Auto-Scaling Group configuration

resource "aws_launch_template" "App_Server_launch_template" {
  name                    = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-app-server-LT"
  description             = "My EC2 Launch Template"
  instance_type          = var.instance_type
  image_id               = var.image_id  # Specify the AMI ID for your desired Amazon Machine Image
  vpc_security_group_ids = [var.private_sg,]  # Specify your security group IDs
  key_name               = "remote-kp" 
  user_data              = base64encode(file("scripts/static-website-user-data.sh"))


  tag_specifications {
    resource_type = "instance"
   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-instance"
  }) 
}
  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "private_autoscaling_group" {
  desired_capacity     = 4
  max_size             = 6
  min_size             = 2
  force_delete         = true
  vpc_zone_identifier = [var.private_subnet1, var.private_subnet2]  # Replace with your private subnet IDs
 
  launch_template {
    id = aws_launch_template.App_Server_launch_template.id
    version = "$Latest"
  }
}