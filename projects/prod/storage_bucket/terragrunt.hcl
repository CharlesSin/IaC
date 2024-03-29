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
  serviceAccount = "terraform_sa.json"
  project_id     = ""
  region         = "asia-east1"
  zone           = "asia-east1-a"
  bucket_name_set = [
    "prod_data_storage",
    "prod_external_data_storage"
  ]
}


