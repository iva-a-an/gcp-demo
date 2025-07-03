output "gke_network_name" {
  description = "Name of the GKE network"
  value       = google_compute_network.gke_network.name
}

output "gke_subnet_name" {
  description = "Name of the GKE subnet"
  value       = google_compute_subnetwork.gke_subnet.name
}
