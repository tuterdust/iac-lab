resource "google_storage_bucket" "lab_bucket" {
  name          = "iac-lab-tf-state-mgmt-${var.owner_name}"
  location      = "ASIA-SOUTHEAST1"
  force_destroy = true
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  labels = merge(var.default_labels, {
    owner : var.owner_name
  })
}