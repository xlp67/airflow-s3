output "vpc_arn" {
  value       = aws_vpc.vpc.arn
  description = "ARN da VPC criada"
}

output "vpc_cidr_block" {
  value       = aws_vpc.vpc.cidr_block
  description = "CIDR da VPC"
}

output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.vpc.id
}

output "subnets-id" {
  value       = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
}

output "sg" {
  value = aws_security_group.sg
}