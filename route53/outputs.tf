# modules/route53/outputs.tf
output "dns_record_id" {
  description = "The ID of the created DNS record"
  value       = aws_route53_record.dns_record.id
}

# output "aws_acm_certificate" {
#   description = "Arn of certificate"
#   value = "arn:aws:acm:us-east-1:450665609241:certificate/9a7f66de-e36b-48f4-83d6-999433ad8479"
# }