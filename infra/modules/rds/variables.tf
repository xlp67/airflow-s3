variable "allocated_storage" {
  description = "Tamanho do armazenamento (GB)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "engine" {
  description = "Motor do banco (ex: mysql, postgres)"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Versão do motor"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Tipo de instância (ex: db.t3.micro)"
  type        = string
  default     = "db.t3.micro"
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

variable "skip_final_snapshot" {
  description = "Pular snapshot final ao destruir"
  type        = bool
  default     = true
}
