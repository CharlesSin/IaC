variable "project_id" {
  description = "The ID of the project in which resources will be provisioned."
  type        = string
}

variable "db_name" {
  description = "The name of the SQL Database instance"
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

variable "authorized_networks" {
  description = "List of mapped public networks authorized to access to the instances. Default - short range of GCP health-checkers IPs"
  type        = list(map(string))
}

variable "network_project_id" {
  description = "The VPC network to host the Cloud SQL"
  type        = string
}

variable "network" {
  description = "The VPC network name"
  type        = string
}

variable "service_account" {
  description = "GCP Service Account path."
  type        = string
}
