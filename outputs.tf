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
      value = random_password.this.result
    },
    {
      name  = "REDSHIFT_URL"
      value = "postgres://${urlencode(local.username)}:${urlencode(random_password.this.result)}@${local.db_endpoint}/${urlencode(local.database_name)}"
    }
  ]
}
