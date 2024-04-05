project_id      = "" # GCP Project ID
region          = "" # GKE 建立在那個 Region
zone            = "" # GKE 建立在那個 Zone
service_account = "" # GCP Service Account 路徑
db_name         = "" # Cloud SQL Instance 名稱
authorized_networks = [{
  name  = "all network" # IP 白名單名稱
  value = "0.0.0.0/24" # 白名單 IP
}]
