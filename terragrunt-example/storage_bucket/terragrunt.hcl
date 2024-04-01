terraform {
  source = "../modules/artifacts_registry"
}

inputs = {
  project_id      = ""
  region          = ""
  zone            = "asia-east1-a"
  bucket_name_set = [
    "example_data_storage",
    "example_external_data_storage"
  ]
}
