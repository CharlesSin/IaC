terraform {
  source = "../../modules/artifacts_registry"
}

remote_state {
  backend = "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    address        = "https://gitlab.com/api/v4/projects/3226/terraform/state/dev_artifacts_registry_terraform.tfstate"
    lock_address   = "https://gitlab.com/api/v4/projects/3226/terraform/state/dev_artifacts_registry_terraform.tfstate/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/3226/terraform/state/dev_artifacts_registry_terraform.tfstate/lock"

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
