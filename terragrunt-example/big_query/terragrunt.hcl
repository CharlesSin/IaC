terraform {
  source = "../modules/big_query"
}

inputs = {
  project_id     = ""
  region         = ""
  serviceAccount = "terraform_sa.json"
}
