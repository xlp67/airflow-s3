module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.1.0.0/16"
    vpc_name = "lm-vpc"
}

module "alb" {
  source                = "./modules/alb"
  launch_template_name  = "ecs-launch-template"
  ami_id                = "ami-0c02fb55956c7d316"
  instance_type         = "t2.micro"
  subnets_id            = module.vpc.subnets-id
  security_group_ids    = [module.vpc.vpc-sg.id]
  depends_on           = [module.vpc]
}

# module "ecs" {
#   source              = "./modules/ecs"
#   subnets_id          = [module.subnet-1.subnet_id, module.subnet-2.subnet_id]
#   security_group_ids  = [module.vpc.vpc-sg.id]
#   depends_on          = [module.alb]
# }


# module "data-wharehouse" {
#   source  = "./modules/rds"
#   db_name        = var.db_name
#   subnets_group_name = "rds-ml-subnets-group"
#   engine         = var.engine
#   engine_version = var.engine_version
#   instance_class = var.instance_class
#   username       = var.username
#   password       = var.password
#   subnets_group = [module.subnet-1.subnet_id, module.subnet-2.subnet_id]


#   depends_on = [module.vpc]
# }