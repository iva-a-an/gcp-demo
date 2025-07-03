

resource "google_service_account" "gke_service_account" {
  account_id   = "${var.env}-gke-service-account"
  display_name = "${var.env}-gke-service-account"
}

# TODO: Rename the resource
resource "google_container_cluster" "gke_cluster" {
  name     = "${var.env}-gke-cluster"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # Connect network and subnet
  network    = var.gke_network_name
  subnetwork = var.gke_subnet_name

  deletion_protection = var.env == "prod" ? true : false

}

resource "google_container_node_pool" "spot_nodes" {
  name       = "${var.env}-gke-node-pool"
  location   = var.region
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1

  node_config {
    preemptible  = var.env == "prod" ? false : true
    machine_type = var.env == "prod" ? "e2-standard-4" : "e2-standard-2"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
