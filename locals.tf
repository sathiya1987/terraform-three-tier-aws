locals{

rds_username = jsondecode(
    data.aws_secretsmanager_secret_version.rds_username.secret_string
  )
rds_password = jsondecode(
    data.aws_secretsmanager_secret_version.rds_password.secret_string
  )
}