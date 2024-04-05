locals {
  read_replica_ip_configuration = {
    ipv4_enabled        = true
    require_ssl         = false
    private_network     = "projects/${var.network_project_id}/global/networks/${var.network}"
    allocated_ip_range  = null
    authorized_networks = var.authorized_networks
  }
}

module "mysql" {
  source  = "terraform-google-modules/sql-db/google//modules/mysql"
  version = "~> 18.0"

  name             = var.db_name
  project_id       = var.project_id
  database_version = "MYSQL_8_0"
  region           = var.region

  deletion_protection = false

  // Master configurations
  tier                            = "db-custom-2-8192" // CPU: 2vCPU, RAM: 8GB
  zone                            = var.zone
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"
  disk_autoresize                 = false
  disk_autoresize_limit           = null
  disk_size                       = 100
  disk_type                       = "PD_SSD"

  database_flags = [{ name = "long_query_time", value = 1 }]

  user_labels = {}

  ip_configuration = {
    ipv4_enabled        = true
    require_ssl         = true
    private_network     = "projects/${var.network_project_id}/global/networks/${var.network}"
    allocated_ip_range  = null
    authorized_networks = var.authorized_networks
  }

  password_validation_policy_config = {
    enable_password_policy      = true
    complexity                  = "COMPLEXITY_DEFAULT"
    disallow_username_substring = true
    min_length                  = 8
  }

  backup_configuration = {
    enabled                        = true
    binary_log_enabled             = true
    start_time                     = "20:55"
    location                       = null
    transaction_log_retention_days = null
    retained_backups               = 365
    retention_unit                 = "COUNT"
  }

  // Read replica configurations
  read_replica_name_suffix = "-test-ha"
  replica_database_version = "MYSQL_8_0"
  read_replicas = [
    {
      name                  = "0"
      zone                  = var.zone
      availability_type     = "ZONAL"
      tier                  = "db-n1-standard-1"
      ip_configuration      = local.read_replica_ip_configuration
      database_flags        = [{ name = "long_query_time", value = 1 }]
      disk_autoresize       = false
      disk_autoresize_limit = null
      disk_size             = 100
      disk_type             = "PD_HDD"
      user_labels           = {}
      encryption_key_name   = null
    },
  ]

  db_name      = var.db_name
  db_charset   = "utf8mb4"
  db_collation = "utf8mb4_general_ci"

  additional_databases = [
    {
      name      = "${var.db_name}-additional"
      charset   = "utf8mb4"
      collation = "utf8mb4_general_ci"
    },
  ]

  user_name     = "USER"
  user_password = ""
  root_password = ""
}
