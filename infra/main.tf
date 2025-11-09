module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.1.0.0/16"
    vpc_name = "lm-vpc"
}

module "rds" {
  source  = "./modules/rds"

  db_name        = var.db_name
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  username       = var.username
  password       = var.password

  depends_on = [module.vpc]
}
