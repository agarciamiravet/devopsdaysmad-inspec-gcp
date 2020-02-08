terraform {
  backend "gcs" {
    bucket  = "devopsdaysmad-terraform"
    prefix  = "terraform/gcp.tfstate"
  }
}