# Create the Cloud Run service
resource "google_cloud_run_service" "run_service" {
  for_each = toset(var.services)
  name     = each.value
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/google-samples/hello-app:1.0"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
