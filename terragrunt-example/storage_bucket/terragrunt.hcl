terraform {
  source = "../modules/artifacts_registry"
}

inputs = {
  project_id      = ""
  region          = ""
  zone            = "asia-east1-a"
  bucket_name_set = [
    "rpa_data_storage",
    "rpa_external_data_storage"
  ]
}
