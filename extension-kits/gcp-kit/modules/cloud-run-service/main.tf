# =============================================================================
# Reusable Terraform Module: Cloud Run Service (Scale-to-Zero)
# =============================================================================
# Generic module for deploying any containerized service to Google Cloud Run
# with Scale-to-Zero enforced. Designed to be consumed by project-specific
# Terraform configurations.
#
# Usage:
#   module "my_service" {
#     source     = "git::https://github.com/pettonativ/gcp-kit.git//modules/cloud-run-service"
#     project_id = "my-project-id"
#     name       = "my-service"
#     image      = "europe-west1-docker.pkg.dev/my-project/my-repo/my-image:latest"
#   }
# =============================================================================

# 1. Enable Required APIs
resource "google_project_service" "cloudrun_api" {
  project            = var.project_id
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

# 2. Cloud Run Service (V2) — Scale-to-Zero
resource "google_cloud_run_v2_service" "service" {
  name     = var.name
  location = var.region
  project  = var.project_id
  ingress  = var.ingress

  template {
    scaling {
      min_instance_count = 0                    # Scale-to-Zero: zero idle costs
      max_instance_count = var.max_instances    # Budget safety cap
    }

    timeout = "${var.request_timeout}s"

    containers {
      image = var.image

      ports {
        container_port = var.container_port
      }

      dynamic "env" {
        for_each = var.env_vars
        content {
          name  = env.value.name
          value = env.value.value
        }
      }

      resources {
        limits = {
          cpu    = var.cpu
          memory = var.memory
        }
        cpu_idle          = true   # CPU only during request processing
        startup_cpu_boost = true   # Reduce cold start latency
      }

      startup_probe {
        timeout_seconds   = var.startup_probe_timeout
        period_seconds    = var.startup_probe_period
        failure_threshold = var.startup_probe_failure_threshold
        tcp_socket {
          port = var.container_port
        }
      }
    }
  }

  depends_on = [google_project_service.cloudrun_api]
}

# 3. Optional: Allow unauthenticated access
resource "google_cloud_run_v2_service_iam_member" "public_access" {
  count    = var.allow_unauthenticated ? 1 : 0
  name     = google_cloud_run_v2_service.service.name
  location = google_cloud_run_v2_service.service.location
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
