variable "env" {
  description = "The environment for which the network is being created (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "The GCP region where the network will be created"
  type        = string
}

variable "gke_network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "gke_subnet_name" {
  description = "Name of the subnet for GKE"
  type        = string
}
