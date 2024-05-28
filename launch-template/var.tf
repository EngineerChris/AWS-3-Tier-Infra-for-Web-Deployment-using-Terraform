variable "tags" {
    type = map(string)
    description = "tags"
}

variable "public_sg" {
    type = string
    description = "security group id"
}

variable "private_sg" {
    type = string
    description = "private security group id"
}

variable "instance_type" {
    type = string
    description = "type of instance"
    default = "t2.micro"
}

variable "image_id" {
    type = string
    description = "AMI id"
    default = "ami-05c13eab67c5d8861"
}

variable "public_subnet1" {
    type = string
    description = "id of public subnet1"
}

variable "public_subnet2" {
    type = string
    description = "id of public subnet2"
}

variable "private_subnet1" {
    type = string
    description = "id of private subnet1"
}

variable "private_subnet2" {
    type = string
    description = "id of private subnet2"
}

# variable "alb_sg" {
#     type = string
#     description = "alb security group"
# }

variable "target_group_arns" {
    type = set(string)
    description = "(optional) describe your variable"
}