variable "region" {
  type        = string
  description = "Google Cloud Region"
  default     = "europe-west1"
}

variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
}

variable "environment" {
  type        = string
  description = "Lifecycle environment"
}

variable "labels" {
  type        = map(string)
  description = "Labels for resources"
  default     = {}
}

variable "force_destroy" {
  type        = bool
  description = "Allows Terraform to delete the bucket when it is destroyed"
  default     = false
}

variable "repository_name" {
  description = "Artifact Registry Repository Name"
  default     = "dataflow-repo-nikolina"
}

variable "image_name" {
  description = "Docker Image Name"
  default     = "dataflow-pipeline"
}

variable "image_tag" {
  description = "Docker Image Tag"
  default     = "latest"
}

variable "metadata_bucket" {
  description = "GCS Bucket for Dataflow Metadata"
  default     = "nikolina-duranec-test/dataflow_template"
}

variable "image_uri" {
  description = "Docker Image URI"
  default     = "dataflow-repo/dataflow-pipeline:latest"
}