variable "private_subnet3" {
    type = string
    description = "private subnet1 id"
}


variable "private_subnet4" {
    type = string
    description = "private subnet2 id"
}

variable "tags" {
    type = map(string)
    description = "tags"
}

variable "vpc_id" {
    type = string
    description = "vpc id"
}

variable "vpc_cidr_block" {
    type = string
    description = "cidr range"
}

variable "private_sg_id" {
    type = string
    description = "id of private security group"
}
