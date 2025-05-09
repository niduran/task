resource "google_artifact_registry_repository" "repository" {
  repository_id = var.repository_name
  location      = var.region
  format        = "DOCKER"
  project       = var.project_id
}


