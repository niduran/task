

resource "google_bigquery_dataset" "dataset" {
  project                    = var.project_id
  dataset_id                 = var.dataset_name
  location                   = var.region
  labels                     = var.labels
  delete_contents_on_destroy = var.force_destroy
}

resource "google_bigquery_table" "smart_meter_table" {

  project             = var.project_id
  deletion_protection = true
  dataset_id          = var.dataset_name
  table_id            = var.smart_meter_table_name

  schema = file("${path.module}/schema/smart_meter.json")

  depends_on = [google_bigquery_dataset.dataset]

  time_partitioning {
    type  = "DAY"
    field = "timestamp"
  }

  clustering = ["meter_id"]
}

resource "google_bigquery_table" "error_table" {

  project             = var.project_id
  deletion_protection = true
  dataset_id          = var.dataset_name
  table_id            = var.error_table_name

  schema = file("${path.module}/schema/error.json")

  depends_on = [google_bigquery_dataset.dataset]
}



