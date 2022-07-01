#providers.tf
aws_region = "ap-south-1"

#cluster.tf
cluster_name = "nginx-cluster"

#task-def.tf
launch_type = ["FARGATE"]
network_type = "awsvpc"
operating_system = "LINUX"

#vpc.tf
vpc_name = "ecs-vpc"
vpc_cidr = "10.0.0.0/16"
availability_zone = ["ap-south-1a","ap-south-1b","ap-south-1c"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets = ["10.0.3.0/24","10.0.4.0/24"]

#alb.tf
abl_name = "ecs-alb"
alb_type = "application"
target_group_prefix = "target"
backend_protocol = "HTTP"
backend_port = 80
lb_target_type = "ip"
listeners_port = 80
listeners_protocol = "HTTP"
target_group_index = 0

#security-groups.tf
alb_sg_name = "alb-sg-ecs"
alb_sg_desc = "Security group for ecs usage with ALB"
alb_sg_cidr = ["0.0.0.0/0"]
alb_sg_ingress_rules = ["http-80-tcp"]
alb_sg_engress_rules = ["all-all"]
ecs_sg_name = "ecs-sg"
ecs_sg_desc = "ecs security group"
ecs_sg_ingress_rules = "all-tcp"
ecs_sg_egress_rules = ["all-all"]

#task-service.tf
container_definition_file = "container_definations.json"
task_cpu = 256
task_memory = 512
ecs_service_name = "ecs-nginx-service"
ecs_launch_type = "FARGATE"
ecs_desired_count = 2
container_name = "nginx"
container_port = 80
