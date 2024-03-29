output "cloud_run_service_name" {
  description = "The ID of the cloud run service "
  value = toset([
    for service in google_cloud_run_service.run_service : service.name
  ])
}

output "cloud_run_service_location" {
  description = "The ID of the cloud run service "
  value = toset([
    for service in google_cloud_run_service.run_service : service.location
  ])
}
