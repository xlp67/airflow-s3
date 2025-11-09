variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "engine" {
  description = "Motor do banco"
  type        = string
}

variable "engine_version" {
  description = "Versão do motor do banco"
  type        = string
}

variable "instance_class" {
  description = "Tipo da instância RDS"
  type        = string
}

variable "username" {
  description = "Usuário administrador do banco"
  type        = string
}

variable "password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}


