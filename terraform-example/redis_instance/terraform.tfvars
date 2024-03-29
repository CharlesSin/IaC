project_id         = "" # GCP Project ID
region             = "" # GKE 建立在那個 Region
zone               = "" # GKE 建立在那個 Zone
service_account    = "" # GCP Service Account 路徑
network            = "" # 網絡名稱，如使用 Shared VPC 需要填寫 Shared VPC 的網絡
name               = "" # redis 的名稱
network_project_id = "" # VPC 網絡所在的 Project ID，如果是 Shared VPC，請填寫上一層的 Project ID
display_name       = "" # redis instance 的名稱
tier               = "BASIC"
memory_size_gb     = 1
replica_count      = 2
read_replicas_mode = "READ_REPLICAS_ENABLED"
connect_mode       = "PRIVATE_SERVICE_ACCESS"
auth_enabled       = false
redis_version      = "REDIS_7_0"
labels             = {}
maintenance_policy = {
  day = "TUESDAY" // 週三早上 6 點 - 7 點 (UTC+8)
  start_time = {
    hours   = 22
    minutes = 0
    seconds = 0
    nanos   = 0
  }
}
redis_configs = {
  "maxmemory-policy" = "volatile-lru"
}
