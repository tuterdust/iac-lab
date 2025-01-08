output "instance_id" {
  value       = google_compute_instance.backend_app.instance_id
  description = "Backend app compute instance ID"
}
