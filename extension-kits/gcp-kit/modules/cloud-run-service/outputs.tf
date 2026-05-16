# =============================================================================
# Outputs for Cloud Run Service Module
# =============================================================================

output "service_url" {
  description = "The URL of the deployed Cloud Run service"
  value       = google_cloud_run_v2_service.service.uri
}

output "service_name" {
  description = "The name of the Cloud Run service"
  value       = google_cloud_run_v2_service.service.name
}

output "service_location" {
  description = "The location/region of the Cloud Run service"
  value       = google_cloud_run_v2_service.service.location
}
