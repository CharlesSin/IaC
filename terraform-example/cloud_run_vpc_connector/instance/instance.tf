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

    metadata {
      annotations = {
        # limit scale up to prevent any cost blow outs!
        "autoscaling.knative.dev/maxScale" = "1"
        # use the VPC Connector above
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector
        # all egress from the service should go through the VPC Connector
        "run.googleapis.com/vpc-access-egress" = "all"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Waits for the Cloud Run API to be enabled
  #   depends_on = [google_project_service.run_api]
  # dev-webpush-server
}

