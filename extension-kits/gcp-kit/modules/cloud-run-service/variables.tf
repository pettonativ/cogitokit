# =============================================================================
# Variables for Cloud Run Service Module
# =============================================================================

# --- Required Variables ---

variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "image" {
  description = "Full Docker image URI (e.g., europe-west1-docker.pkg.dev/project/repo/image:tag)"
  type        = string
}

# --- Optional Variables (with sensible defaults) ---

variable "region" {
  description = "GCP region for the Cloud Run service"
  type        = string
  default     = "europe-west1"
}

variable "cpu" {
  description = "CPU limit (e.g., '1000m' for 1 vCPU, '2000m' for 2 vCPU)"
  type        = string
  default     = "1000m"
}

variable "memory" {
  description = "Memory limit (e.g., '512Mi', '2048Mi', '4096Mi')"
  type        = string
  default     = "512Mi"
}

variable "max_instances" {
  description = "Maximum number of instances (budget safety cap)"
  type        = number
  default     = 2
}

variable "container_port" {
  description = "The port the container listens on (Cloud Run injects PORT env var)"
  type        = number
  default     = 8080
}

variable "request_timeout" {
  description = "Maximum time (in seconds) for a single request"
  type        = number
  default     = 300
}

variable "ingress" {
  description = "Ingress traffic setting: INGRESS_TRAFFIC_ALL, INGRESS_TRAFFIC_INTERNAL_ONLY, INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
  type        = string
  default     = "INGRESS_TRAFFIC_ALL"
}

variable "env_vars" {
  description = "List of environment variables to set on the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "allow_unauthenticated" {
  description = "Whether to allow unauthenticated access to the service"
  type        = bool
  default     = false
}

# --- Startup Probe (for heavy containers with ML models, etc.) ---

variable "startup_probe_timeout" {
  description = "Timeout in seconds for the startup probe"
  type        = number
  default     = 10
}

variable "startup_probe_period" {
  description = "Period in seconds between startup probe checks"
  type        = number
  default     = 10
}

variable "startup_probe_failure_threshold" {
  description = "Number of consecutive failures before the container is considered unhealthy"
  type        = number
  default     = 3
}
