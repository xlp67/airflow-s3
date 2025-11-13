variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "number_of_subnets" {
  description = "Number of subnets to create"
  type        = number
}
