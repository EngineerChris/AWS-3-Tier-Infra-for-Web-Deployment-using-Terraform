# variables.tf
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default = "172.16.0.0/16"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}

variable "subnet_cidr_blocks" {
  description = "List of subnet CIDR blocks"
  type        = list(string)
  default = [ "172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24", "172.16.4.0/25", "172.16.5.0/24", "172.16.6.0/24" ]
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# variable "rds_sg" {
#   type = string
#   description = "id of RDS security group"
# }

