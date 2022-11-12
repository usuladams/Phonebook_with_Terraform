output "db_sg" {
  value = aws_security_group.db-sg
}

output "server_sg" {
  value = aws_security_group.server-sg
}

output "alb_sg" {
  value = aws_security_group.alb-sg
}