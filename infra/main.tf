module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr_block    = "10.0.0.0/16"
  number_of_subnets = 2
}

resource "aws_security_group" "ecs_sg" {
  name        = "ecs-sg"
  description = "Security group for ECS Airflow"
  vpc_id      = module.vpc.vpc_id
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "ecs" {
  source                  = "./modules/ecs"
  ecs_cluster_name        = "airflow-cluster"
  ecs_cluster_region      = "us-east-1"
  containerInsights       = "enabled"
  ecs_cluster_environment = "dev"
  execution_role_arn      = module.iam.ecs_exec_role
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.subnet_ids
  security_group_id       = aws_security_group.ecs_sg.id
}
