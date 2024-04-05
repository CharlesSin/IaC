output "webpush_dataset_id" {
  description = "The ID of the dataset"
  value       = google_bigquery_dataset.dataset_name.dataset_id
}
