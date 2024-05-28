output "rds_sg" {
  description = "id of RDS security group"
  value = aws_security_group.rds_sg.id
}

