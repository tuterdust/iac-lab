# locals {
#   owner_email = "{PUT_YOUR_ENROLLED_EMAIL_HERE}"
#   owner_name  = replace(split("@", local.owner_email)[0], ".", "-")
# }

# resource "google_cloud_run_service" "this" {
#   name     = "copilot-lab--cloud-run-${local.owner_name}"
#   location = "asia-southeast1"
#   template {
#     spec {
#       containers {
#         image = "asia-southeast1-docker.pkg.dev/iac-lab-447109/lab-registry/backend-app:1.2"
#         resources {
#           limits = {
#             memory = "128Mi"
#             cpu    = "0.25"
#           }
#         }
#       }
#     }
#   }

#   metadata {
#     annotations = {
#       "run.googleapis.com/ingress" = "all"
#     }

#     labels = merge(var.default_labels, {
#       owner = local.owner_name
#     })
#   }
# }

# resource "google_cloud_run_service_iam_member" "this" {
#   service  = google_cloud_run_service.this.name
#   location = google_cloud_run_service.this.location
#   role     = "roles/run.invoker"
#   member   = "allUsers"
# }

# output "cloud_run_service_url" {
#   value       = google_cloud_run_service.this.status[0].url
#   description = "The URL of the Cloud Run service."
# }


# terraform {
#   required_version = "~> 1.6.2"

#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 6.14.1"
#     }
#   }
# }

# provider "google" {
#   project = "iac-lab-447109"
#   region  = "asia-southeast1"
# }

# variable "default_labels" {
#   type = map(string)
#   default = {
#     tf-project-name = "tf-state-management"
#   }
#   description = "default labels"
# }
