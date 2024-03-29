variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  type        = string
}

variable "zone" {
  description = "GCP Service Zone."
  type        = string
}

variable "network" {
  description = "The VPC network to host the cluster in"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
  type        = string
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  type        = string
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
  type        = string
}

variable "enable_binary_authorization" {
  description = "Enable BinAuthZ Admission controller"
  type        = bool
}

# PD example
variable "regional" {
  description = "是否為 Regional GKE，預設為 false (為 Zonal GKE)，如果是 true，需填寫 region 來指定區域 (選填)"
  type        = bool
}

variable "region" {
  description = "叢集地區性，Ex: asia-east1，如果是 Regional GKE，則必填"
  type        = string
}

variable "kubernetes_version" {
  description = "GKE 版本，預設為 latest，如果是 latest，會自動抓該區域的最新版本，也可以自行輸入想要的版本 (選填)"
  type        = string
}

//備註的說明還需要測試與調整
variable "name" {
  description = "叢集名稱 (必填)"
  type        = string
}

variable "zones" {
  description = "叢集區域，Ex: asia-east1-b，如果是 Zonal GKE，則必填，如果是 Regional GKE，想要指定 zone，也可以在這邊設定 (選填)"
  type        = list(string)
}

variable "node_pools" {
  type        = list(map(any))
  description = "Node Pool 的相關設定 (必填)"
  default = [
    {
      name = "default-node-pool"
    }
  ]
}

variable "release_channel" {
  type        = string
  description = "GKE 發布頻道 (選填)"
  default     = "STABLE"
  validation {
    condition     = contains(["UNSPECIFIED", "STABLE", "REGULAR"], var.release_channel)
    error_message = "不符合 GKE 發布頻道的設定，請輸入 UNSPECIFIED 或 STABLE 或 REGULAR (不會使用到快速版，所以沒有開放輸入)"
  }
}

variable "network_project_id" {
  type        = string
  description = "共享 VPC 專案的 ID，如果沒有設定，預設為專案 ID (選填)"
  default     = ""
}

variable "gcs_fuse_csi_driver" {
  type        = bool
  description = "是否允許將 GCS 儲存桶作為磁碟空間，預設為關閉 (選填)"
  default     = false
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "授權的主網路清單，如果沒有設定，則會禁止外部存取 (叢集節點 IP 除外，GKE 會自動將其加入白名單)，預設為空 (選填)"
  default     = []
}

variable "maintenance_start_time" {
  type        = string
  description = "使用 RFC3339 格式，指定週期性維護的開始時間 (時區是 UTC+0) (選填)"
  default     = "2023-01-01T14:00:00Z" # 轉換為 22:00 (UTC+8)
}

variable "maintenance_end_time" {
  type        = string
  description = "使用 RFC3339 格式，指定週期性維護的結束時間 (時區是 UTC+0) (選填)"
  default     = "2023-01-01T21:00:00Z" # 轉換為 05:00 (UTC+8)
}

variable "maintenance_recurrence" {
  type        = string
  description = "使用 RFC3339 格式，指定週期性維護的頻率 (選填)"
  default     = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR,SA,SU"
}

variable "enable_maintenance" {
  type        = bool
  description = "是否啟用維護，如果不能自動更新，則需設定 false (選填)"
  default     = true
}

variable "cluster_dns_provider" {
  type        = string
  description = "叢集預設 DNS 提供者，預設為 PROVIDER_UNSPECIFIED (選填)"
  default     = "PROVIDER_UNSPECIFIED"
  validation {
    condition     = contains(["PROVIDER_UNSPECIFIED", "PLATFORM_DEFAULT", "CLOUD_DNS"], var.cluster_dns_provider)
    error_message = "不符合叢集預設 DNS 提供者的設定，請輸入 PROVIDER_UNSPECIFIED 或 PLATFORM_DEFAULT 或 CLOUD_DNS"
  }
}

variable "cluster_dns_scope" {
  type        = string
  description = "叢集 DNS 記錄的存取範圍，預設為 DNS_SCOPE_UNSPECIFIED (選填)"
  default     = "DNS_SCOPE_UNSPECIFIED"
  validation {
    condition     = contains(["DNS_SCOPE_UNSPECIFIED", "CLUSTER_SCOPE", "VPC_SCOPE"], var.cluster_dns_scope)
    error_message = "不符合叢集 DNS 記錄的存取範圍的設定，請輸入 DNS_SCOPE_UNSPECIFIED 或 CLUSTER_SCOPE 或 VPC_SCOPE"
  }
}

variable "enable_workload_identity" {
  type        = bool
  description = "是否啟用 Workload Identity，啟用後，workload pool 預設為 `[project_id].svc.id.goog`，預設為開啟 (選填)"
  default     = true
}

variable "cluster_resource_labels" {
  type        = map(string)
  description = "叢集 GCE 的資源標籤，使用 Key Value 的方式，預設為空 (選填)"
  default = {
    "time" : "abc"
  }
}

variable "logging_enabled_components" {
  type        = list(string)
  description = "GKE 日誌元件 (選填)"
  default     = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  validation {
    condition     = can(setsubtract(["SYSTEM_COMPONENTS", "WORKLOADS", "APISERVER", "CONTROLLER_MANAGER", "SCHEDULER"], var.logging_enabled_components))
    error_message = "不符合 GKE 日誌元件的設定，支援的值包括 SYSTEM_COMPONENTS、WORKLOADS、APISERVER、CONTROLLER_MANAGER 或 SCHEDULER"
  }
}

variable "monitoring_enabled_components" {
  type        = list(string)
  description = "GKE 指標元件 (選填)"
  default     = ["SYSTEM_COMPONENTS"]
  validation {
    condition     = can(setsubtract(["SYSTEM_COMPONENTS", "APISERVER", "SCHEDULER", "CONTROLLER_MANAGER", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT"], var.monitoring_enabled_components))
    error_message = "不符合 GKE 指標元件的設定，支援的值包括 SYSTEM_COMPONENTS、APISERVER、SCHEDULER、CONTROLLER_MANAGER、STORAGE、HPA、POD、DAEMONSET、DEPLOYMENT"
  }
}

variable "monitoring_enable_managed_prometheus" {
  type        = bool
  description = "是否啟用 GMP (Google Managed Prometheus) 監控，預設為開啟 (選填)"
  default     = true
}

variable "timeouts" {
  type        = map(string)
  description = "叢集操作的 timeout 設定 (選填)"
  default     = {}
  validation {
    condition     = !contains([for t in keys(var.timeouts) : contains(["create", "update", "delete"], t)], false)
    error_message = "只允許 create、update、delete 這三種 timeout 設定"
  }
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "GKE 控制層 IP 範圍，目前需自己建立，SR 尚未控管 (必填)"
  default     = "172.16.0.0/28"
}

variable "service_account" {
  type        = string
  description = "每個節點使用的服務帳戶，如果沒有設定，預設為 `default` (選填)"
  # default     = "terraform-sa@goap-201904.iam.gserviceaccount.com"
  default     = "default"
}

variable "enable_private_nodes" {
  type        = bool
  description = "是否啟用 private nodes，在叢集上建立專用端點，節點僅有內部 IP，透過私有網路與主節點的私有端點通訊，預設為開啟 (選填)"
  default     = false
}

variable "enable_private_endpoint" {
  type        = bool
  description = "是否啟用 private endpoint，叢集的專用端點作為叢集端點，並停用透過公用端點來存取，預設為關閉 (選填)"
  default     = false
}

/******************************************
  以下變數會在 variables_defaults.tf 裡預先處理
 *****************************************/

variable "node_pools_tags" {
  type        = map(list(string))
  description = "node pool 的網路 tag 設定 (選填)"

  default = {
    all = []
  }
}

variable "node_pools_oauth_scopes" {
  type        = map(list(string))
  description = "node pool 的 oauth scopes 設定 (選填)"

  default = {
    all = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }
}

variable "node_pools_labels" {
  type        = map(map(string))
  description = "node pool 的 label 設定 (選填)"

  default = {
    all = {}
  }
}

variable "node_pools_taints" {
  type        = map(list(object({ key = string, value = string, effect = string })))
  description = "node pool 的 taint 設定 (需要設定 key、value、effect) (選填)"

  default = {
    all = []
  }
}

variable "node_pools_metadata" {
  type        = map(map(string))
  description = "node pool 的 metadata 設定 (選填)"

  default = {
    all = {}
  }
}

variable "serviceAccount" {
  description = "GCP Project Service Account."
  type        = string
}
