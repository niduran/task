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

variable "dag_bucket_name" {
  type        = string
  description = "dag bucket name"
  default     = "dags_bucket_test"
}

variable "dataflow_template_bucket_name" {
  type        = string
  description = "dataflow template bucket name"
  default     = "dataflow_bucket_test_1"
}