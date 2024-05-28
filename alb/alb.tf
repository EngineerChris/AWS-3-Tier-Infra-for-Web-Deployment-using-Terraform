resource "aws_lb" "alb" {
  name               = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]  # Replace with your security group ID
  subnets            = [var.public_subnet1, var.public_subnet2]  # Replace with your subnet IDs

  enable_deletion_protection = false  # Set to true if you want to enable deletion protection
  
    tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-alb"
  }) 
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200,301,302"
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# create a listener on port 80 with redirect action
# terraform aws create listener
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn 
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


# Create a listener on port 443 with SSL certificate
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn  = aws_lb.alb.arn
  port               = 443
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = "arn:aws:acm:us-east-1:450665609241:certificate/9a7f66de-e36b-48f4-83d6-999433ad8479"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}