resource "aws_db_instance" "this" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password

  skip_final_snapshot  = var.skip_final_snapshot

  publicly_accessible  = false
  deletion_protection  = true
  multi_az             = false
  storage_encrypted    = true
}