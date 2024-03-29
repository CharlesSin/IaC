variable "project_id" {
  description = "The ID of the project in which resources will be provisioned."
  type        = string
}

variable "region" {
  description = "GCP Project Region."
  type        = string
}

variable "zone" {
  description = "GCP Service Zone."
  type        = string
}

variable "service_account" {
  description = "GCP Service Account path."
  type        = string
}

# PD example
variable "network_project_id" {
  description = "共享 VPC 專案的 ID，如果沒有設定，預設為專案 ID (選填)"
  type        = string
}

variable "name" {
  description = "Memorystore 名稱 (必填)"
  type        = string
}

variable "display_name" {
  description = "Memorystore 顯示名稱 (選填)"
  type        = string
}

variable "tier" {
  default     = "BASIC"
  description = "Memorystore 個體類型 (選填)"
  type        = string
  validation {
    condition     = contains(["BASIC", "STANDARD_HA"], var.tier)
    error_message = "不符合 Memorystore 個體類型的值，請輸入 BASIC 或 STANDARD_HA"
  }
}

variable "memory_size_gb" {
  default     = 1
  description = "Memorystore memory 分配容量，預設為 1 (單位: GiB) (選填)"
  type        = number
}

variable "replica_count" {
  default     = 2
  description = "Memorystore replicas 數量，預設為 2，如果 tier 是 BASIC，則不用設定 (選填)"
  type        = number
}

variable "read_replicas_mode" {
  default     = "READ_REPLICAS_ENABLED"
  description = "Memorystore 讀取 replicas 模式，如果 tier 是 BASIC，則不用設定 (選填)"
  type        = string
  validation {
    condition     = contains(["READ_REPLICAS_DISABLED", "READ_REPLICAS_ENABLED"], var.read_replicas_mode)
    error_message = "不符合 Memorystore 讀取 replicas 模式的值，請輸入 READ_REPLICAS_DISABLED 或 READ_REPLICAS_ENABLED"
  }
}

variable "network" {
  description = "Memorystore 網路名稱 (必填)"
  type        = string
}

variable "connect_mode" {
  default     = "PRIVATE_SERVICE_ACCESS"
  description = "Memorystore 連線模式 (選填)"
  type        = string
  validation {
    condition     = contains(["DIRECT_PEERING", "PRIVATE_SERVICE_ACCESS"], var.connect_mode)
    error_message = "不符合 Memorystore 連線模式的值，請輸入 DIRECT_PEERING 或 PRIVATE_SERVICE_ACCESS"
  }
}

variable "auth_enabled" {
  default     = false
  description = "是否啟用 Memorystore Redis 的身份驗證，預設為 true (選填)"
  type        = bool
}

variable "maintenance_policy" {
  default = {
    day = "TUESDAY" // 週三早上 6 點 - 7 點 (UTC+8)
    start_time = {
      hours   = 22
      minutes = 0
      seconds = 0
      nanos   = 0
    }
  }
  description = "Memorystore Redis 維護排程 (選填)"
  type = object({
    day = string
    start_time = object({
      hours   = number
      minutes = number
      seconds = number
      nanos   = number
    })
  })
}

variable "redis_version" {
  description = "Memorystore Redis 版本 (選填)"
  default     = "REDIS_7_0"
  type        = string
  validation {
    condition     = contains(["REDIS_5_0", "REDIS_6_X", "REDIS_7_0"], var.redis_version)
    error_message = "不符合 Memorystore Redis 版本的值，請輸入 REDIS_5_0 或 REDIS_6_X 或 REDIS_7_0"
  }
}

variable "redis_configs" {
  description = "Memorystore Redis 設定參數 (https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs) (選填)"
  default = {
    "maxmemory-policy" = "volatile-lru" // 很重要
  }
  type = map(any)
}

variable "labels" {
  description = "Memorystore 標籤，預設為空 (選填)"
  default     = {}
  type        = map(string)
}
