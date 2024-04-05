terraform {
  source = "../../modules/sql_instance_mysql_ha"
}

remote_state {
  backend = "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    address        = "https://gitlab.com/api/v4/projects/3226/terraform/state/prod_sql_instance_mysql_ha_terraform.tfstate"
    lock_address   = "https://gitlab.com/api/v4/projects/3226/terraform/state/prod_sql_instance_mysql_ha_terraform.tfstate/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/3226/terraform/state/prod_sql_instance_mysql_ha_terraform.tfstate/lock"

    username = ""
    password = ""

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  serviceAccount     = "terraform_sa.json"
  project_id         = ""
  region             = ""
  zone               = ""
  network            = ""
  network_project_id = ""
  db_name            = "mysql-database"
  authorized_networks = [{
    name  = "all network"
    value = "0.0.0.0/24"
  }]
}


