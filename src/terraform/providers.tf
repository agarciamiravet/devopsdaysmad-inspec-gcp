#
provider "google" {
  credentials = file(var.credentials-file)
  project     = "devopsdays-madrid"
  region      = "europe-west3"
  zone        = "europe-west3-a"
  version     = "3.7"
}