module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.1.0.0/16"
    vpc_name = "lm-vpc"
}

# module "subnet-1" {
#   source            = "./modules/subnet"
#   subnet_name       = "ml-subnet-1"
#   subnet_cidr_block = "10.1.1.0/24"
#   availability_zone = "us-east-1a"
#   vpc_id            = module.vpc.vpc_id
#   depends_on        = [module.vpc]
# }

# module "subnet-2" {
#   source            = "./modules/subnet"
#   subnet_name       = "ml-subnet-2"
#   subnet_cidr_block = "10.1.2.0/24"
#   availability_zone = "us-east-1b"
#   vpc_id            = module.vpc.vpc_id
#   depends_on        = [module.vpc]
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

module "raw-layer" {
  source    = "./modules/s3"
  bucket_id = "raw-layer"
}
module "silver-layer" {
  source    = "./modules/s3"
  bucket_id = "silver-layer"
}
module "gold-layer" {
  source    = "./modules/s3"
  bucket_id = "gold-layer"
}