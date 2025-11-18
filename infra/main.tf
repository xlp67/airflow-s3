module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.1.0.0/16"
    vpc_name = "lm-vpc"
}

module "s3" {
    source = "./modules/s3"
    bucket_id = "lm-bucket-xlp67"
}

output "s3_bucket_arn" {
  value = module.s3.bucket_name_arn
  }

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