variable "tags" {
    type = map(string)
    description = "tags"
}

variable "alb_sg" {
    type = string
    description = "alb security group"
}

variable "public_subnet1" {
    type = string
    description = "public subnet1 id"
}

variable "public_subnet2" {
    type = string
    description = "public subnet2 id"
}

variable "vpc_id" {
    type = string
    description = "id of vpc"
}

variable "alb_arn" {
    type = string
    description = "arn of ALB"
}

# variable "aws_acm_certificate" {
#     type = string
#     description = "(optional) describe your variable"
# }