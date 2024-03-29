project_id                           = "" # GCP Project ID
region                               = "" # GKE 建立在那個 Region
zone                                 = "" # GKE 建立在那個 Zone，如果是建立在 Regional 這可以留空
serviceAccount                       = "" # GCP Service Account 路徑
cluster_name_suffix                  = "" # GKE Cluster 名稱
network                              = "" # 網絡名稱，如使用 Shared VPC 需要填寫 Shared VPC 的網絡
subnetwork                           = "" # 子網絡名稱，如使用 Shared VPC 請填寫 Shared VPC 的網絡
ip_range_pods                        = "" # 給 GKE Pod 使用的子網絡。/18 網段
ip_range_services                    = "" # 給 GKE Pod 使用的子網絡。/24 網段
enable_binary_authorization          = false
regional                             = false # GKE 是否要建立在 Regional
kubernetes_version                   = ""    # GKE 版本
name                                 = ""    # GKE Cluster 名稱
zones                                = [""]  # GKE Cluster 建立在那個 Zone
release_channel                      = "STABLE"
network_project_id                   = "" # VPC 網絡所在的 Project ID，如果是 Shared VPC，請填寫上一層的 Project ID
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
master_ipv4_cidr_block               = "" # IPv4 服務範圍 
service_account                      = "" # GKE Cluster 使用的 Service Account
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
