resource "google_bigquery_table" "table_name" {
  dataset_id          = var.webpush_id
  project             = var.project_id
  schema              = ""   # Schema Structure 
  table_id            = ""   # Table ID
  deletion_protection = true # 防止刪除功能
}
