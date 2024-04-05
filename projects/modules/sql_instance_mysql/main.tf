resource "random_id" "name" {
  byte_length = 2
}

locals {
  # If name_override is specified, use that - otherwise use the name_prefix with a random string
  instance_name = var.db_name
}

module "mysql" {
  source  = "terraform-google-modules/sql-db/google//modules/mysql"
  version = "~> 18.0"

  name             = local.instance_name
  database_version = "MYSQL_8_0"
  project_id       = var.project_id
  region           = var.region

  // Master configurations
  tier                            = "db-custom-2-8192" // CPU: 2vCPU, RAM: 8GB
  zone                            = var.zone
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"
  disk_autoresize                 = true
  disk_autoresize_limit           = null
  disk_size                       = 100
  disk_type                       = "PD_SSD"

  deletion_protection = false

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = "projects/${var.network_project_id}/global/networks/${var.network}"
    require_ssl         = false
    allocated_ip_range  = null
    authorized_networks = var.authorized_networks
  }

  database_flags = [
    {
      name  = "log_bin_trust_function_creators"
      value = "on"
    },
  ]

  user_name     = "USER"
  user_password = ""
  root_password = ""
}
