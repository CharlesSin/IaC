resource "google_bigquery_dataset" "WebPush" {
  dataset_id    = "WebPush"
  friendly_name = "WebPush"
  description   = "Webpush Dataset"
  location      = "asia-east1"
}
