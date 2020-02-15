provider "google" {
  credentials = file(var.credentials_file)
  project     = "devopsdays-madrid"
  region      = "europe-west3"
  zone        = "europe-west3-a"
  version     = "3.7"
}