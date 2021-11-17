data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = "data.aws_secretsmanager_secret.username.id"
}
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = "data.aws_secretsmanager_secret.password.id"
}


