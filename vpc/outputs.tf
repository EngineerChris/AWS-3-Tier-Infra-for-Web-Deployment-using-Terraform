# outputs.tf
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.primary_vpc.id
}

# outputs.tf
output "public_subnet1_id" {
  description = "Public subnet id"
  value       = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  description = "public subnet id"
  value       = aws_subnet.public_subnet2.id
}

output "private_subnet1_id" {
  description = "Private subnet id"
  value       = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  description = "Private subnet id"
  value       = aws_subnet.private_subnet2.id
}

output "private_subnet3_id" {
  description = "Private subnet id"
  value       = aws_subnet.private_subnet3.id
}

output "private_subnet4_id" {
  description = "Private subnet id"
  value       = aws_subnet.private_subnet4.id
}

output "public_sg_id" {
  description = "public security group id"
  value = aws_security_group.public_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

output "alb_sg" {
  description = " security group id"
  value = aws_security_group.alb_sg.id
}

output "vpc_cidr_block" {
  description = "cidr block of vpc"
  value = "172.16.0.0/16"
}