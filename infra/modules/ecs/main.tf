resource "aws_ecs_capacity_provider" "ecs-capacity-provider" {
  name = "ecs-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 75
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 1000
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs-cluster-capacity-providers" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = [
    aws_ecs_capacity_provider.ecs-capacity-provider.name
  ]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs-capacity-provider.name
    weight            = 1
    base              = 1
  }
}

resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                   = "ecs-task"
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::577927099755:role/ecsTaskExecutionRole"
  cpu = 1024

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "nginx:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "ecs-service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs-task-definition.arn
  desired_count   = 2

  network_configuration {
    subnets         = var.subnets_id
    security_groups = var.security_group_ids
  }

  force_new_deployment = true

  placement_constraints {
    type = "distinctInstance"
  }

  triggers = {
    redeployment = timestamp()
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs-capacity-provider.name
    weight            = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs-tg.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.ecs-listener]
}