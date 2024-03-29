resource "google_cloud_run_service_iam_member" "run_all_users" {
  for_each = toset(var.cloud_run_name)
  service  = each.value
  location = var.cloud_run_location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
