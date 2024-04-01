terraform {
  source = "../modules/artifacts_registry"
}

inputs = {
  project_id         = ""
  region             = ""
  zone               = "asia-east1-a"
  network            = "staging"
  network_project_id = "gcp-202011216-001"
  db_name            = "mysql-database"
  authorized_networks = [{
    name  = "all network"
    value = "0.0.0.0/24"
  }]
}
