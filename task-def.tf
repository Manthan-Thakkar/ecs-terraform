resource "aws_ecs_task_definition" "nginx-task" {
  family = var.cluster_name
  container_definitions = file(var.container_definition_file)
  cpu = var.task_cpu
  memory = var.task_memory
  requires_compatibilities = var.launch_type
  network_mode = var.network_type
  execution_role_arn = aws_iam_role.task_def_role.arn
  runtime_platform {
    operating_system_family = var.operating_system
  }
}
resource "aws_iam_role" "task_def_role" {
  name = "ECS-bhubadminportal-TaskDefinationRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role_policy" "ecr-iam-policy" {
  name = "ecr-read-access"
  role = aws_iam_role.task_def_role.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        }
    ]
})
}