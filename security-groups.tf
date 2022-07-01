module "alb-sg" {
  source  = "terraform-aws-modules/security-group/aws"

  name        = var.alb_sg_name
  description = var.alb_sg_desc
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = var.alb_sg_cidr
  ingress_rules       = var.alb_sg_ingress_rules
  egress_rules        = var.alb_sg_engress_rules
}

module "ecs-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name = var.ecs_sg_name
  description = var.ecs_sg_desc
  vpc_id = module.vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      rule = var.ecs_sg_ingress_rules
      source_security_group_id = module.alb-sg.security_group_id
    }
  ]
  
  # ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["all-tcp"]
  egress_rules        = var.alb_sg_engress_rules
}