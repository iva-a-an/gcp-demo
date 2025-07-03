# Generate random suffix for resource names
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
  lower   = true
}

# Create backend storage bucket for Terraform state management
resource "google_storage_bucket" "terraform_state" {
  name                        = "${var.env}-terraform-state-${random_string.suffix.result}"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  labels = {
    environment = var.env
    managed_by  = "terraform"
  }

  depends_on = [google_project_service.storage]
}

#Add terraform service account to the bucket
resource "google_storage_bucket_iam_member" "private_access" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.backet_admin}"
}

# Enable API services for the project
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}
resource "google_project_service" "storage" {
  service = "storage.googleapis.com"
}
resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
}
# Enable the Google Kubernetes Engine API
resource "google_project_service" "gke" {
  service = "container.googleapis.com"
}
