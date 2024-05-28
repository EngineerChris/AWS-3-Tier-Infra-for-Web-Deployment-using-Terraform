# vpc.tf
resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-primary-vpc"
  }) 
}

# main.tf
resource "aws_subnet" "public_subnet1" {
  vpc_id         = aws_vpc.primary_vpc.id
  cidr_block     = var.subnet_cidr_blocks[0]
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-subnet1"
  }) 
}

resource "aws_subnet" "public_subnet2" {
  vpc_id         = aws_vpc.primary_vpc.id
  cidr_block     = var.subnet_cidr_blocks[1]
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-subnet2"
  }) 
}

resource "aws_subnet" "private_subnet1" {
  vpc_id         = aws_vpc.primary_vpc.id
  cidr_block     = var.subnet_cidr_blocks[2]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet1"
  }) 
}

resource "aws_subnet" "private_subnet2" {
  vpc_id         = aws_vpc.primary_vpc.id
  cidr_block     = var.subnet_cidr_blocks[3]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet2"
  }) 
}

resource "aws_subnet" "private_subnet3" {
  vpc_id         = aws_vpc.primary_vpc.id
  cidr_block     = var.subnet_cidr_blocks[4]
  availability_zone = var.availability_zones[0]

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet3"
  }) 
}

resource "aws_subnet" "private_subnet4" {
  vpc_id         = aws_vpc.primary_vpc.id
  cidr_block     = var.subnet_cidr_blocks[5]
  availability_zone = var.availability_zones[1]

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-subnet4"
  }) 
}

resource "aws_internet_gateway" "primary_igw" {
  vpc_id = aws_vpc.primary_vpc.id

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-primary-igw"
  }) 
}

resource "aws_route_table" "primary_public_route_table" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.primary_igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-rt"
  }) 
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.primary_public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.primary_public_route_table.id
}

# beform creating a subnet association for private subnets, you first need to create
# eip and a NAT gw

resource "aws_eip" "eip" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-nat-eip"
  }) 
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id   # reference eip id
  subnet_id = aws_subnet.public_subnet1.id
  depends_on = [ aws_eip.eip, aws_subnet.public_subnet1 ]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id  # reference nat gateway id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-rt"
  }) 
}




# 2nd NAT Gateway for AZ-b
resource "aws_eip" "eip_azb" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-nat-eip-azb"
  }) 
}

resource "aws_nat_gateway" "nat_gw_azb" {
  allocation_id = aws_eip.eip_azb.id   # reference eip id
  subnet_id = aws_subnet.public_subnet2.id
  depends_on = [ aws_eip.eip_azb, aws_subnet.public_subnet2 ]
}

resource "aws_route_table" "private_route_table_azb" {
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_azb.id  # reference nat gateway id
  }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-rt-azb"
  }) 
}



resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table_azb.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table_azb.id
}

resource "aws_route_table_association" "private_subnet3_association" {
  subnet_id = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.private_route_table_azb.id
}

resource "aws_route_table_association" "private_subnet4_association" {
  subnet_id = aws_subnet.private_subnet4.id
  route_table_id = aws_route_table.private_route_table_azb.id
}


# Public Security Group for ec2 instances

resource "aws_security_group" "public_sg" {
  name        = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-sg"
  description = "allow http traffic"
  vpc_id      = aws_vpc.primary_vpc.id

    ingress {
    description      = "allow ssh traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    
    ingress {
    description      = "allow http traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-public-sg"
  }) 
}

# Private Security Group for private ec2 instances being created by an auto-scaling group

resource "aws_security_group" "private_sg" {
  name        = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-sg"
  description = "allow ssh and http traffic"
  vpc_id      = aws_vpc.primary_vpc.id

    ingress {
    description      = "allow ssh traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    
    ingress {
    description      = "allow ssh traffic"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-private-sg"
  }) 
}




resource "aws_security_group" "alb_sg" {
  name        = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-alb-sg"
  description = "allow http traffic"
  vpc_id      = aws_vpc.primary_vpc.id

  ingress {
    description      = "allow http traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "allow https traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}