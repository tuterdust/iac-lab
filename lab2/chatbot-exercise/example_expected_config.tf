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

variable "bucket_name_prefix" {
  type        = string
  default     = "chatbot-lab"
  description = "The name of the storage bucket"
}

resource "google_storage_bucket" "example" {
  name                        = "${var.bucket_name_prefix}-${random_id.suffix.hex}" # Unique bucket name with suffix
  location                    = "ASIA-SOUTHEAST1"                                   # Singapore region
  storage_class               = "STANDARD"                                          # Standard class
  uniform_bucket_level_access = true                                                # Uniform access for better security
  public_access_prevention    = "enforced"                                          # Prevents public access

  versioning {
    enabled = true # Enable versioning
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 7 # Retention of 7 days
    }
  }
}

resource "random_id" "suffix" {
  byte_length = 4 # Generates a 4-byte random suffix
}

output "bucket_name" {
  value       = google_storage_bucket.example.name
  description = "The name of the storage bucket"
}

output "bucket_url" {
  value       = "gs://${google_storage_bucket.example.name}"
  description = "The GCS bucket URL"
}
