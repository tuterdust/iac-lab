variable "gcp_project_id" {
  type        = string
  description = "Google Cloud Platform Project ID"
}

variable "gcp_region" {
  type        = string
  description = "Google Cloud Platform region"
}

variable "machine_type" {
  type        = string
  description = "Type of compute instance"
}

variable "machine_zone" {
  type        = string
  description = "Availability zone of compute instance"
}

variable "initialize_image" {
  type        = string
  description = "initialize image of compute instance"
}

variable "ssh_pub_key_path" {
  type        = string
  description = "Path to SSH public key for the compute instance"
  default     = "~/.ssh/id_rsa.pub"
}

variable "default_labels" {
  type = map(string)
  default = {
    tf-project-name = "tf-state-management"
  }
  description = "default labels"
}

variable "owner_name" {
  type        = string
  description = "owner_name"
}
