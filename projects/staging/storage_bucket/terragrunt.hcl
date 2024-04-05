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
    address        = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_storage_bucket_terraform.tfstate"
    lock_address   = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_storage_bucket_terraform.tfstate/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_storage_bucket_terraform.tfstate/lock"

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
  region         = ""
  zone           = ""
  bucket_name_set = [
    "staging_data_storage",
    "staging_external_data_storage"
  ]

}


