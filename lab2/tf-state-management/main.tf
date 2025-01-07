locals {
  owner_email = {PUT_YOUR_ENROLLED_EMAIL_HERE}
  owner_name  = replace(split("@", local.owner_email)[0], ".", "-")
}


resource "google_storage_bucket" "lab_bucket" {
  name          = "iac-lab-tf-state-mgmt-${local.owner_name}"
  location      = "ASIA-SOUTHEAST1"
  force_destroy = true
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  labels = merge(var.default_labels, {
    owner : local.owner_name
  })
}
