resource "google_storage_bucket" "dag_bucket" {
  name          = var.dag_bucket_name
  location      = var.region
  project       = var.project_id
  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "dataflow_bucket" {
  name          = var.dataflow_template_bucket_name
  location      = var.region
  project       = var.project_id
  force_destroy = true

  uniform_bucket_level_access = true
}

