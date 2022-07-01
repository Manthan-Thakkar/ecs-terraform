# resource "aws_lb_target_group" "ecs-lb-target" {
#   name = "ecs-lb-target-group"
#   port = 80
#   protocol = "HTTP"
#   target_type = "ip"
#   vpc_id = module.vpc.vpc_id
# }

module "alb" {
  source = "terraform-aws-modules/alb/aws"
  name = var.abl_name
  load_balancer_type = var.alb_type

  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  security_groups = [module.alb-sg.security_group_id]
  
  target_groups = [
    {
        name_prefix = var.target_group_prefix
        backend_protocol = var.backend_protocol
        backend_port = var.backend_port
        target_type = var.lb_target_type
    }
  ]

  http_tcp_listeners = [
    {
        port = var.listeners_port
        protocol = var.listeners_protocol
        target_group_index = var.target_group_index
    }
  ]
}