resource "google_artifact_registry_repository" "helm" {
  description   = "存放 Helm Charts 的，當作版控"
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
  repository_id = "helm"
}

resource "google_artifact_registry_repository" "platform" {
  description   = "平台 Image Registry"
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
  repository_id = "platform"
}

resource "google_artifact_registry_repository" "url_shortener" {
  description   = "短網址 Images Registry"
  format        = "DOCKER"
  location      = var.region
  project       = var.project_id
  repository_id = "url-shortener"
}
