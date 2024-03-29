terraform {
  source = "../../modules/storage_bucket"
}

remote_state {
  backend = "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    address        = "https://swissknife.vip/api/v4/projects/3226/terraform/state/staging_storage_bucket_terraform.tfstate"
    lock_address   = "https://swissknife.vip/api/v4/projects/3226/terraform/state/staging_storage_bucket_terraform.tfstate/lock"
    unlock_address = "https://swissknife.vip/api/v4/projects/3226/terraform/state/staging_storage_bucket_terraform.tfstate/lock"

    username = ""
    password = ""

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  serviceAccount = "terraform_sa.json"
  project_id     = ""
  region         = "asia-east1"
  zone           = "asia-east1-a"
  bucket_name_set = [
    "rpa_staging_data_storage",
    "rpa_staging_external_data_storage"
  ]

}


