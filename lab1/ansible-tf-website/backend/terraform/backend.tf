data "google_service_account" "backend_compute" {
  account_id = "backend-compute"
}

resource "google_compute_instance" "backend_app" {
  name         = "backend-app-${var.owner_name}"
  machine_type = var.machine_type
  zone         = var.machine_zone


  boot_disk {
    initialize_params {
      image = var.initialize_image
    }
  }

  network_interface {
    network = "default"

    access_config {

    }
  }

  metadata = {
    ssh-keys = "${var.owner_name}:${file(var.ssh_pub_key_path)}"
  }

  service_account {
    email  = data.google_service_account.backend_compute.email
    scopes = ["cloud-platform"]
  }

  labels = merge(var.default_labels, {
    "owner" = var.owner_name
  })
}
