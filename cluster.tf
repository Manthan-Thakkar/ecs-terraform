resource "aws_ecs_cluster" "nginx-cluster" {
  name = var.cluster_name
}