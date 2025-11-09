output "db_instance_endpoint" {
  description = "Endpoint do banco de dados"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_identifier" {
  description = "Identificador do banco de dados"
  value       = aws_db_instance.this.id
}
