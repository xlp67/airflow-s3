variable "ecs_cluster_name" {}
variable "ecs_cluster_region" {}
variable "containerInsights" {}
variable "ecs_cluster_environment" {}
variable "execution_role_arn" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
