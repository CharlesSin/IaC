terraform {
  source = "../../modules/big_query"
}

remote_state {
  backend = "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    address        = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_big_query_terraform.tfstate"
    lock_address   = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_big_query_terraform.tfstate/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_big_query_terraform.tfstate/lock"

    username = ""
    password = ""

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  project_id     = ""
  region         = ""
  serviceAccount = "terraform_sa.json"
}


