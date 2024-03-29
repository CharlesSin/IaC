variable "project_id" {
  description = "The ID of the project in which resources will be provisioned."
  type        = string
}

variable "region" {
  description = "GCP Project Region."
  type        = string
}

variable "service_account" {
  description = "GCP Service Account path."
  type        = string
}
