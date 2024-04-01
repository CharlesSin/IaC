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
    address        = "https://swissknife.vip/api/v4/projects/3226/terraform/state/prod_sql_instance_mysql_ha_terraform.tfstate"
    lock_address   = "https://swissknife.vip/api/v4/projects/3226/terraform/state/prod_sql_instance_mysql_ha_terraform.tfstate/lock"
    unlock_address = "https://swissknife.vip/api/v4/projects/3226/terraform/state/prod_sql_instance_mysql_ha_terraform.tfstate/lock"

    username = "charles_sin"
    password = "glpat-8KMzXCtYP4nZACcDm36t"

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  serviceAccount     = "terraform_sa.json"
  project_id         = "gcp-20240322-002"
  region             = "asia-east1"
  zone               = "asia-east1-a"
  network            = "prod"
  network_project_id = "gcp-202011216-001"
  db_name            = "rpa-mysql-database"
  authorized_networks = [{
    name  = "34B-Wifi-Network"
    value = "111.235.135.0/24"
  }]
}


