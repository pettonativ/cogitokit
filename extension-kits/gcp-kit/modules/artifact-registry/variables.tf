variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "repository_id" {
  description = "The ID of the Artifact Registry repository"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "description" {
  description = "Description for the repository"
  type        = string
  default     = "Docker repository"
}
