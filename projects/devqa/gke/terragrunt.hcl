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
    address        = "https://swissknife.vip/api/v4/projects/3226/terraform/state/dev_gke_terraform.tfstate"
    lock_address   = "https://swissknife.vip/api/v4/projects/3226/terraform/state/dev_gke_terraform.tfstate/lock"
    unlock_address = "https://swissknife.vip/api/v4/projects/3226/terraform/state/dev_gke_terraform.tfstate/lock"

    username = "charles_sin"
    password = "glpat-8KMzXCtYP4nZACcDm36t"

    lock_method   = "POST"
    unlock_method = "DELETE"
    retry_max     = 5
  }
}

inputs = {
  serviceAccount                       = "terraform_sa.json"
  project_id                           = "gcp-20240215-001"
  region                               = "asia-east1"
  zone                                 = "asia-east1-a"
  cluster_name_suffix                  = "dev-cluster"
  network                              = "testdev"
  subnetwork                           = "testdev"
  ip_range_pods                        = "gke-pods"
  ip_range_services                    = "gke-service"
  enable_binary_authorization          = false
  regional                             = false
  kubernetes_version                   = "latest"
  name                                 = "dev-cluster"
  zones                                = ["asia-east1-a"]
  release_channel                      = "STABLE"
  network_project_id                   = "gcp-202011216-001"
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
  master_ipv4_cidr_block               = "172.16.0.144/28"
  service_account                      = "gke-cluster-sa@gcp-20240215-001.iam.gserviceaccount.com"
  enable_private_nodes                 = false
  enable_private_endpoint              = false
  cluster_resource_labels              = { "time" : "2023-01-26" }
  node_pools                           = [{ name = "default-node-pool" }]
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
