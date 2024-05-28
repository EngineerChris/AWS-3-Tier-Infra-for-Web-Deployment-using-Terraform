resource "aws_route53_record" "dns_record" {
  name    = var.domain_name
  type    = "A"
  zone_id = var.route53_zone_id

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# Define SSL certificate (replace with your actual ARN)
# resource "aws_acm_certificate" "ssl_certificate" {
#   domain_name       = "ernestcosmicfilms.com"
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }