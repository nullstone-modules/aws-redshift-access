output "env" {
  value = [
    {
      name  = "REDSHIFT_USER"
      value = local.username
    },
    {
      name  = "REDSHIFT_DB"
      value = local.database_name
    }
  ]
}

output "secrets" {
  value = [
    {
      name  = "REDSHIFT_PASSWORD"
      value = local.password
    },
    {
      name  = "REDSHIFT_URL"
      value = "postgres://${urlencode(local.username)}:${urlencode(local.password)}@${local.db_endpoint}/${urlencode(local.database_name)}"
    }
  ]
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = local.password_secret_name
}

locals {
  password = jsondecode(data.aws_secretsmanager_secret_version.password.secret_string)["password"]
}
