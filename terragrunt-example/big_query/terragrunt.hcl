terraform {
  source = "../modules/artifacts_registry"
}

inputs = {
  project_id     = ""
  region         = ""
  serviceAccount = "terraform_sa.json"
}
