locals {
  owner_name = {OWNER_NAME}
}

resource "google_storage_bucket" "static_site" {
  name                        = "iac-lab-static-frontend-${local.owner_name}"
  location                    = "asia-southeast1"
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  labels = merge(var.default_labels, {
    owner : local.owner_name
  })
}

resource "google_storage_bucket_iam_member" "allow_all" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_object" "static_files_object" {
  for_each = fileset("./frontend-src/", "**")

  bucket = google_storage_bucket.static_site.name
  name   = each.key
  source = "./frontend-src/${each.key}"
  content_type = lookup({
    ".html" = "text/html",
    ".css"  = "text/css",
    ".js"   = "application/javascript"
  }, substr(each.key, -5, 5), "application/octet-stream")
}