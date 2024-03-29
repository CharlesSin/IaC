variable "project_id" {
  description = "The ID of the project in which resources will be provisioned."
  type        = string
}

variable "region" {
  description = "GCP Project Region."
  type        = string
}

variable "services" {
  description = "List of Cloud Run services to create"
  type        = list(string)
  default     = []
}

variable "serviceAccount" {
  description = "GCP Project Service Account."
  type        = string
}
