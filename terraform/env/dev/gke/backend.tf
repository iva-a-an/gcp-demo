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

  # CRITICAL: ENSURE THE BACKEND IS UNIQUE TO AVOID CONFLICTS
  backend "gcs" {
    bucket      = "dev-terraform-state-vvef"
    prefix      = "terraform/gke_state"
    credentials = "~/.config/gcloud/dev_terraform_cred.json"
  }

  required_version = ">= 0.12"
}

provider "google" {
  # Configuration options
  region  = "us-central1"
  project = "dev-gcp-demo"
}

# add netwrork remote terraform state
data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket      = "dev-terraform-state-vvef"
    prefix      = "terraform/network_state"
    credentials = "~/.config/gcloud/dev_terraform_cred.json"
  }
}
