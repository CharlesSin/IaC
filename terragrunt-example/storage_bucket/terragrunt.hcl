terraform {
  source = "../modules/storage_bucket"
}

inputs = {
  project_id      = ""
  region          = ""
  zone            = ""
  bucket_name_set = [
    "example_data_storage",
    "example_external_data_storage"
  ]
}
