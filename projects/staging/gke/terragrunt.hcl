terraform {
  source = "../../modules/gke"
}

remote_state {
  backend = "http"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    address        = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_gke_terraform.tfstate"
    lock_address   = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_gke_terraform.tfstate/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/3226/terraform/state/staging_gke_terraform.tfstate/lock"

    username = ""
    password = ""

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  serviceAccount                       = "terraform_sa.json"
  project_id                           = ""
  region                               = ""
  zone                                 = ""
  cluster_name_suffix                  = "cluster"
  network                             = ""
  subnetwork                           = ""
  ip_range_pods                        = "gke-pods"
  ip_range_services                    = "gke-service"
  enable_binary_authorization          = false
  regional                             = false
  kubernetes_version                   = "latest"
  name                                 = "cluster"
  zones                                = [""]
  release_channel                      = "STABLE"
  network_project_id                   = ""
  gcs_fuse_csi_driver                  = false
  master_authorized_networks           = []
  maintenance_start_time               = "2023-01-01T14:00:00Z" # 轉換為 22:00 (UTC+8)
  maintenance_end_time                 = "2023-01-01T21:00:00Z" # 轉換為 05:00 (UTC+8)
  maintenance_recurrence               = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR,SA,SU"
  enable_maintenance                   = true
  cluster_dns_provider                 = "PROVIDER_UNSPECIFIED"
  cluster_dns_scope                    = "DNS_SCOPE_UNSPECIFIED"
  enable_workload_identity             = true
  logging_enabled_components           = ["SYSTEM_COMPONENTS", "WORKLOADS", "APISERVER", "CONTROLLER_MANAGER", "SCHEDULER"]
  monitoring_enabled_components        = ["SYSTEM_COMPONENTS", "APISERVER", "SCHEDULER", "CONTROLLER_MANAGER", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT"]
  monitoring_enable_managed_prometheus = true
  timeouts                             = {}
  master_ipv4_cidr_block               = ""
  service_account                      = ""
  enable_private_nodes                 = false
  enable_private_endpoint              = false
  cluster_resource_labels              = { "time" : "2023-01-26" }
  node_pools                           = [{ name = "default-node-pool", machine_type = "n2-standard-8" }]
  node_pools_tags                      = { all = [] }
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }
  node_pools_labels   = { all = {} }
  node_pools_taints   = { all = [] }
  node_pools_metadata = { all = {} }
}
