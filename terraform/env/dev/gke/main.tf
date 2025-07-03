module "gke" {
  source           = "../../../modules/gke"
  env              = "dev"
  region           = "us-central1-a"
  gke_network_name = data.terraform_remote_state.network.outputs.gke_network_name
  gke_subnet_name  = data.terraform_remote_state.network.outputs.gke_subnet_name
}
