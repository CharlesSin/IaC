resource "google_storage_bucket" "static" {
  for_each                 = toset(var.bucket_name_set)
  name                     = each.value
  project                  = var.project_id
  location                 = var.region
  storage_class            = "STANDARD"
  public_access_prevention = "inherited"
  force_destroy            = false

  uniform_bucket_level_access = true
}
