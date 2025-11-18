variable "launch_template_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "security_group_ids" {
    type = list(string)
}
variable "subnets_id" {}
variable "vpc_id" {}
