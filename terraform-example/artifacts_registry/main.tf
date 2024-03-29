resource "google_artifact_registry_repository" "name" {
  description   = "" # 描述
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
  repository_id = "name" # repo id
}
