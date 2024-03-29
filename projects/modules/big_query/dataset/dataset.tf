resource "google_bigquery_dataset" "WebPush" {
  dataset_id    = "WebPush"
  friendly_name = "WebPush"
  description   = "RPA Webpush Dataset"
  location      = "asia-east1"
}
