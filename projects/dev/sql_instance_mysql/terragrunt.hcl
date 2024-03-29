terraform {
  source = "../../modules/sql_instance_mysql"
}

remote_state {
  backend = "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    address        = ""
    lock_address   = ""
    unlock_address = ""

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
  region             = "asia-east1"
  zone               = "asia-east1-a"
  network            = ""
  network_project_id = ""
  db_name            = "dev-mysql-database"
  authorized_networks = [{
    name  = "all network"
    value = "0.0.0.0/24"
  }]
}


