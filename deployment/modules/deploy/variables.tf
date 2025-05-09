variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "region" {
  type        = string
  description = "Google Cloud Region"
  default     = "europe-west1"
}

variable "labels" {
  type        = map(string)
  description = "Labels for resources"
  default     = {}
}

variable "enable_apis" {
  type        = bool
  description = "Enable required Google Cloud APIs"
  default     = false
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket deletion"
  default     = false
}

variable "environment" {
  type        = string
  description = "Lifecycle environment"
  default     = "dev"
}

variable "dag_bucket_name" {
  type        = string
  description = "dag bucket name"
  default     = "dag_bucket_test"
}

variable "dataflow_template_bucket_name" {
  type        = string
  description = "dataflow template bucket name"
  default     = "dataflow_bucket_test_1"
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
  default     = "dataflow_bucket_test_1"
}

variable "image_uri" {
  description = "Docker Image URI"
  default     = "dataflow-repo/dataflow-pipeline:latest"
}

variable "dataset_name" {
  type        = string
  description = "name of dataset"
  default     = "measurements"
}

variable "topic_name" {
  type        = string
  description = "topic name"
  default     = "smart_meter_topic"
}

variable "subscription_name" {
  type        = string
  description = "subscription name"
  default     = "smart_meter_sub"
}

variable "smart_meter_table_name" {
  type        = string
  description = "smart meter table name"
  default     = "smart_meter"
}

variable "error_table_name" {
  type        = string
  description = "error table name"
  default     = "errors"
}
