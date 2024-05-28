module "vpc" {
  source = "./vpc"
  tags = local.project_tags
}

module "aws_launch_template" {
  source = "./launch-template"
  tags = local.project_tags
  public_sg = module.vpc.public_sg_id
  private_sg = module.vpc.private_sg_id
  public_subnet1 = module.vpc.public_subnet1_id
  public_subnet2 = module.vpc.public_subnet2_id
  private_subnet1 = module.vpc.private_subnet1_id
  private_subnet2 = module.vpc.private_subnet2_id
  target_group_arns = module.alb.target_group_arns
}

module "alb" {
  source = "./alb"
  tags = local.project_tags
  alb_sg = module.vpc.alb_sg
  public_subnet1 = module.vpc.public_subnet1_id
  public_subnet2 = module.vpc.public_subnet2_id
  vpc_id = module.vpc.vpc_id
  alb_arn = module.alb.alb_arn
}

module "route53" {
  source = "./route53"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
}

module "rds" {
  source = "./rds"
  tags = local.project_tags
  private_subnet3 = module.vpc.private_subnet3_id
  private_subnet4 = module.vpc.private_subnet4_id
  vpc_id = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  private_sg_id = module.vpc.private_sg_id
}

