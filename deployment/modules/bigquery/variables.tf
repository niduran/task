# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "deletion_protection" {
  type        = string
  description = "Whether or not to protect GCS resources from deletion when solution is modified or changed."
  default     = false
}

variable "force_destroy" {
  type        = string
  description = "Whether or not to protect GCS resources from deletion when solution is modified or changed."
  default     = false
}

variable "team_name" {
  type        = string
  description = "The name of the team associated with the Dataplex DataScan resource."
  default     = "labsdqgcp"
}

variable "environment" {
  type        = string
  description = "Lifecycle environment"
}

variable "region" {
  type        = string
  description = "Google Cloud Region"
}

variable "labels" {
  type        = map(string)
  description = "Labels for resources"
}

variable "dataset_name" {
  type        = string
  description = "name of dataset"
  default     = "measurements"
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
