variable "env" {
  description = "The environment for which the network is being created (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "The GCP region where the network will be created"
  type        = string
}
