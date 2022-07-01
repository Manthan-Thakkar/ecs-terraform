resource "aws_ecs_service" "ecs-nginx-service" {
  name = var.ecs_service_name
  cluster = aws_ecs_cluster.nginx-cluster.id
  task_definition = aws_ecs_task_definition.nginx-task.arn
  launch_type = var.ecs_launch_type
  desired_count = var.ecs_desired_count
  
  load_balancer {
    target_group_arn = module.alb.target_group_arns[0]
    container_name = var.container_name
    container_port = var.container_port
  }
  
  network_configuration {
    subnets = [for subnets in module.vpc.private_subnets : subnets ]
    # subnets = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
    security_groups = [module.ecs-sg.security_group_id]
  }
}