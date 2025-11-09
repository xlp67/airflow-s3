output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID da VPC criada"
}

output "vpc_arn" {
  value       = aws_vpc.main.arn
  description = "ARN da VPC criada"
}

output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
  description = "CIDR da VPC"
}
