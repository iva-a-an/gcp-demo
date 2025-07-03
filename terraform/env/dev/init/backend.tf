terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>6.42.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.5.1"
    }
  }
  required_version = ">= 0.12"
}

provider "google" {
  # Configuration options
  region  = "us-central1"
  project = "dev-gcp-demo"
}
