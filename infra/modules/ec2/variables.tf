variable "subnet_id" {}
variable "name" {}
variable "ami_id" {}
variable "user_data" {
  description = "User data script para instância EC2"
  type        = string
  default     = ""
}

variable "instance_type" {}