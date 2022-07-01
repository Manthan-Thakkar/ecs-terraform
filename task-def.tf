# module "nginx_container_def" {
#   source = "cloudposse/ecs-container-definition/aws"

#   container_name = "nginx"
#   container_image = "nginx"
# }


resource "aws_ecs_task_definition" "nginx-task" {
  family = var.cluster_name
  container_definitions = file(var.container_definition_file)
  cpu = var.task_cpu
  memory = var.task_memory
  requires_compatibilities = var.launch_type
  network_mode = var.network_type
  runtime_platform {
    operating_system_family = var.operating_system
  }
}