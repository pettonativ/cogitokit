output "repository_url" {
  description = "The full URL of the Artifact Registry repository"
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}"
}

output "repository_id" {
  description = "The repository ID"
  value       = google_artifact_registry_repository.docker_repo.repository_id
}
