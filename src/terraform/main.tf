
provider "google" {
  credentials = "${file("/opt/terraform/gcp-credentials.json")}"
  project     = "devopsdays-madrid"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_project_service" "kubernetes" {
  project = "devopsdays-madrid"
  service = "container.googleapis.com"
}

resource "google_container_cluster" "kubernetes" {
  name               = "k8s-cluster"
  depends_on         = ["google_project_service.kubernetes"]
  initial_node_count = 1

  master_auth {
    username = ""
    password = ""
  }
  }
