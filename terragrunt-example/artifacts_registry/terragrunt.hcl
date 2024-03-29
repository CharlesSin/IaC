terraform {
  source = "../modules/artifacts_registry"
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

    lock_method = ""
    unlock_method = ""
    retry_max = 5
  }
}

inputs = {
  project_id              = ""
  region                  = ""
  serviceAccount          = "terraform_sa.json"
}