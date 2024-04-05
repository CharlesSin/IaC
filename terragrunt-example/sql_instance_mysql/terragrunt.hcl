terraform {
  source = "../modules/sql_instance_mysql"
}

inputs = {
  project_id         = ""
  region             = ""
  zone               = ""
  network           = ""
  network_project_id = ""
  db_name            = "mysql-database"
  authorized_networks = [{
    name  = "all network"
    value = "0.0.0.0/24"
  }]
}
