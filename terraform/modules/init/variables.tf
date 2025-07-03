variable "env" {
  description = "The environment for which the network is being created (e.g., dev, prod)"
  type        = string
}

variable "backet_admin" {
  description = "Email of the user who should have access to the bucket"
  type        = string
}
