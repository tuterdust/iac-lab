variable "machine_type" {
  type = string
}

variable "machine_zone" {
  type = string
}

variable "initialize_image" {
  type = string
}

variable "default_labels" {
  type = map(string)
  default = {
    tf-project-name = "tf-state-management"
  }
  description = "default labels"
}

variable "owner_name" {
  type = string
}
