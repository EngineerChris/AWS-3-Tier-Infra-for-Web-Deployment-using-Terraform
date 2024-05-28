# modules/route53/main.tf
variable "domain_name" {
  description = "The domain name for the DNS record"
  type = string
  default = "ernestcosmicfilms.com"
}

variable "alb_dns_name" {
  description = "The DNS name of the load balancer to alias to"
  type = string
}

variable "alb_zone_id" {
  description = "The Route 53 hosted zone ID"
  type = string
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID"
  type = string
  default = "Z04532242TW69A9T4K43F"
}

# # modules/route53/outputs.tf
# output "dns_record_id" {
#   description = "The ID of the created DNS record"
#   value       = aws_route53_record.dns_record.id
# }

