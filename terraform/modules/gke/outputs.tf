output "gke_cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.gke_cluster.name
}

output "gke_cluster_location" {
  description = "The location of the GKE cluster"
  value       = google_container_cluster.gke_cluster.location
}
