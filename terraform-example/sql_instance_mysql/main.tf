resource "random_id" "name" {
  byte_length = 2
}

locals {
  # If name_override is specified, use that - otherwise use the name_prefix with a random string
  instance_name        = var.db_name
  private_network_name = "private-network-${random_id.name.hex}"
  private_ip_name      = "private-ip-${random_id.name.hex}"
}

# ------------------------------------------------------------------------------
# CREATE COMPUTE NETWORKS
# ------------------------------------------------------------------------------

# Simple network, auto-creates subnetworks
resource "google_compute_network" "private_network" {
  name = local.private_network_name
}

# Reserve global internal address range for the peering
resource "google_compute_global_address" "private_ip_address" {
  name          = local.private_ip_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.self_link
}

# Establish VPC network peering connection using the reserved address range
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

module "mysql-db" {
  source  = "terraform-google-modules/sql-db/google//modules/mysql"
  version = "~> 18.0"

  name             = local.instance_name
  database_version = "MYSQL_8_0"
  project_id       = var.project_id
  zone             = var.zone
  region           = var.region
  tier             = "db-n1-standard-1"

  deletion_protection = false

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = "projects/${var.network_project_id}/global/networks/${var.network}"
    require_ssl         = true
    allocated_ip_range  = null
    authorized_networks = var.authorized_networks
  }

  database_flags = [
    {
      name  = "log_bin_trust_function_creators"
      value = "on"
    },
  ]
}
