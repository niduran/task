variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
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