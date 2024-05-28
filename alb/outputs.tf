# output "certificate_arn" {
#   description = "arn of certificate"
#   value = "arn:aws:acm:us-east-1:450665609241:certificate/9a7f66de-e36b-48f4-83d6-999433ad8479"
# }

output "alb_arn" {
  description = "arn of ALB"
  value = aws_lb.alb.arn
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}

output "aws_lb" {
  value = aws_lb.alb.id
}

output "target_group_arns" {
  value = [aws_lb_target_group.alb_target_group.arn]
}