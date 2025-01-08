locals {
  owner_email = "{PUT_YOUR_ENROLLED_EMAIL_HERE}"
  owner_name  = replace(split("@", local.owner_email)[0], ".", "-")
}

resource "google_cloud_run_service" "this" {
  name     = "copilot-lab--cloud-run-${local.owner_name}"
  location = "" # Update: change location to singapore region
  template {
    spec {
      containers {
        image = "asia-southeast1-docker.pkg.dev/iac-lab-447109/lab-registry/backend-app:1.2"
        resources {
          limits = { # Update : Ask copilot team to decrease the resources limit
            memory = "256Mi"
            cpu    = "1"
          }
        }
      }
    }
  }

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "" # Missing: Add metadata annotation for public access
    }

    labels = merge(var.default_labels, {
      owner = local.owner_name
    })
  }
}

resource "google_cloud_run_service_iam_member" "this" {
  service  = google_cloud_run_service.this.name
  location = google_cloud_run_service.example.location # Update: change wroing resouce id
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Missing: Add an output to display the service's URL for testing


terraform {
  required_version = "~> 1.6.2"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.14.1"
    }
  }
}

provider "google" {
  project = "iac-lab-447109"
  region  = "asia-southeast1"
}

variable "default_labels" {
  type = map(string)
  default = {
    tf-project-name = "tf-state-management"
  }
  description = "default labels"
}
