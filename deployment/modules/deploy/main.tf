locals {
  env = var.environment
}

module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = ">= 15.0.0"
  disable_services_on_destroy = false
  project_id                  = var.project_id
  enable_apis                 = var.enable_apis

  activate_apis = [
    "cloudapis.googleapis.com",
    "cloudbuild.googleapis.com",
    "config.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
  ]
}

module "storage_setup" {
  source      = "../buckets"
  project_id  = var.project_id
  environment = local.env
  region      = var.region
  labels      = var.labels
}

module "bigquery_setup" {
  source      = "../bigquery"
  project_id  = var.project_id
  environment = local.env
  region      = var.region
  labels      = var.labels
  dataset_name = var.dataset_name
  smart_meter_table_name = var.smart_meter_table_name
  error_table_name = var.error_table_name
}

module "pubsub_setup" {
  source      = "../pubsub"
  project_id = var.project_id
  topic_name = var.topic_name
  subscription_name = var.subscription_name
}

module "artifact_registry_setup" {
  source      = "../artifact_registry"
  project_id  = var.project_id
  environment = local.env
  region      = var.region
  labels      = var.labels
  repository_name = var.repository_name
}