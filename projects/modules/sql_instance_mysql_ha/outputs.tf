output "project_id" {
  value = var.project_id
}

output "name" {
  description = "The name for Cloud SQL instance"
  value       = module.mysql.instance_name
}

output "replicas" {
  value     = module.mysql.replicas
  sensitive = true
}

output "instances" {
  value     = module.mysql.instances
  sensitive = true
}
