resource "aws_db_instance" "this" {
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  allocated_storage    = 10
  db_subnet_group_name = aws_db_subnet_group.this.name

  publicly_accessible  = false
  deletion_protection  = false
  multi_az             = false
  storage_encrypted    = false
}

resource "aws_db_subnet_group" "this" {
  name       = var.subnets_group_name
  subnet_ids = var.subnets_group

  tags = {
    Name = var.subnets_group_name
  }
}
