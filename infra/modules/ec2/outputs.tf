output "instance_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP da instância EC2"
}

