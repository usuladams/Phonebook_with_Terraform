resource "aws_db_instance" "db-server" {
  instance_class = "db.t2.micro"
  allocated_storage = 20
  vpc_security_group_ids = [var.db_sg_id]
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = true
  backup_retention_period = 0
  identifier = "phonebook-app-db"
  name = "phonebook"
  engine = "mysql"
  engine_version = "8.0.23"
  username = "admin"
  password = "Paul123456789"
  monitoring_interval = 0
  multi_az = false
  port = 3306
  publicly_accessible = false
  skip_final_snapshot = true

}