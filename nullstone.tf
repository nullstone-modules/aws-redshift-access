terraform {
  required_providers {
    ns = {
      source = "nullstone-io/ns"
    }
  }
}

data "ns_workspace" "this" {}

resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = false
  special = false
}

locals {
  resource_name = "${data.ns_workspace.this.block_ref}-${random_string.resource_suffix.result}"
}

data "ns_connection" "redshift" {
  name = "redshift"
  type = "redshift/aws"
  contract = "datastore/aws/redshift"
}

locals {
  db_endpoint          = data.ns_connection.redshift.outputs.db_endpoint
  db_subdomain         = split(":", local.db_endpoint)[0]
  db_port              = split(":", local.db_endpoint)[1]
  db_security_group_id = data.ns_connection.redshift.outputs.db_security_group_id
  username             = data.ns_connection.redshift.outputs.db_username
  database_name        = data.ns_connection.redshift.outputs.db_database
  password_secret_name = data.ns_connection.redshift.outputs.db_master_secret_name
}
