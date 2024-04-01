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
    address        = "https://swissknife.vip/api/v4/projects/3226/terraform/state/staging_artifacts_registry_terraform.tfstate"
    lock_address   = "https://swissknife.vip/api/v4/projects/3226/terraform/state/staging_artifacts_registry_terraform.tfstate/lock"
    unlock_address = "https://swissknife.vip/api/v4/projects/3226/terraform/state/staging_artifacts_registry_terraform.tfstate/lock"

    username = "charles_sin"
    password = "glpat-8KMzXCtYP4nZACcDm36t"

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  project_id     = "gcp-20240131-013"
  region         = "asia-east1"
  serviceAccount = "terraform_sa.json"
}
