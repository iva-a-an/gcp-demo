# Create network resources
resource "google_compute_network" "gke_network" {
  name                    = "${var.env}-vpc-network"
  auto_create_subnetworks = false
  description             = "network for GKE cluster"
}
resource "google_compute_subnetwork" "gke_subnet" {
  name          = "${var.env}-subnet"
  network       = google_compute_network.gke_network.id
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  description   = "Subnet for GKE cluster"

  secondary_ip_range {
    range_name    = "${var.env}-pod-range"
    ip_cidr_range = "10.1.0.0/16"
  }
}
