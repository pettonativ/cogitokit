# =============================================================================
# Reusable Terraform Module: Artifact Registry (Docker)
# =============================================================================
# Generic module for creating Docker repositories on Google Artifact Registry.
# =============================================================================

resource "google_project_service" "artifactregistry_api" {
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  repository_id = var.repository_id
  format        = "DOCKER"
  location      = var.region
  description   = var.description

  depends_on = [google_project_service.artifactregistry_api]
}
