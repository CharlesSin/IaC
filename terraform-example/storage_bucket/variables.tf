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

variable "bucket_name_set" {
  description = "A set of GCS bucket names..."
  type        = list(string)
}

variable "service_account" {
  description = "GCP Service Account path."
  type        = string
}
