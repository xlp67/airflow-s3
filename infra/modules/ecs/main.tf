resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
  region = var.ecs_cluster_region
  setting {
    name  = "containerInsights"
    value = var.containerInsights
  }
  tags = {
    Environment = var.ecs_cluster_environment
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "airflow-task-compose"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "4096"
  memory                   = "8192"
  execution_role_arn       = var.execution_role_arn

  container_definitions = file("${path.module}/container_definitions.json")
}

# resource "aws_ecs_service" "airflow_service" {
#   name            = "airflow-service"
#   cluster         = aws_ecs_cluster.this.id
#   task_definition = aws_ecs_task_definition.this.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets          = [aws_subnet.public_1.id, aws_subnet.public_2.id]
#     assign_public_ip = true
#     security_groups  = [aws_security_group.ecs_sg.id]
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.airflow_tg.arn
#     container_name   = "airflow-webserver"
#     container_port   = 8080
#   }

#   depends_on = [
#     aws_lb_listener.front_end
#   ]
# }



