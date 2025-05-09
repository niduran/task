resource "google_pubsub_topic" "smart_meter" {
  project       = var.project_id
  name = var.topic_name
}

resource "google_pubsub_subscription" "smart_meter_sub" {
  project       = var.project_id
  name  = "smart-meter-sub"
  topic = google_pubsub_topic.smart_meter.name
}