terraform {
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
