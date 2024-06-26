# to create an RDS, you need 
# a db subnet group made up of private subnets
# a db security group
# the db instance

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-subnet-group"
  subnet_ids = [var.private_subnet3, var.private_subnet4]

      tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-subnet-group"
  })
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-rds-sg"
  description = "Allow db traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "DB port"
    from_port        = 3306  # MySQL
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"  # allows any type of protocol
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

    tags = merge(var.tags,{
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-rds-sg"
  })
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = "jjtech"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id  # dependencies
  vpc_security_group_ids = [aws_security_group.rds_sg.id, var.private_sg_id]      # dependencies
}


# Private App Server Security Group

