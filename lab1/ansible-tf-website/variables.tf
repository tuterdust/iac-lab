variable "default_labels" {
  type = map(string)
  default = {
    tf-project-name = "tf-state-management"
  }
  description = "default labels"
}
