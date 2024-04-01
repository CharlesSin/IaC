variable "project_id" {
  description = "The project to run tests against"
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

variable "db_name" {
  description = "The name for Cloud SQL instance"
  type        = string
}

variable "authorized_networks" {
  description = "List of mapped public networks authorized to access to the instances. Default - short range of GCP health-checkers IPs"
  type        = list(map(string))
}

variable "network_project_id" {
  type        = string
  description = "共享 VPC 專案的 ID，如果沒有設定，預設為專案 ID (選填)"
  default     = ""
}

variable "network" {
  description = "Cloud SQL 網路名稱 (必填)"
  type        = string
}

variable "serviceAccount" {
  description = "GCP Project Service Account."
  type        = string
}
