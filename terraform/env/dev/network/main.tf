module "network" {
  source = "../../../modules/network"
  env    = "dev"
  region = "us-central1"
}
