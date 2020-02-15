output "bucket_name" {
  value = google_storage_bucket.devopsdays-storage.name
}

output "bucket_id" {
   value = google_storage_bucket.devopsdays-storage.id
}

output "bucket_link" {
  value = google_storage_bucket.devopsdays-storage.self_link
}

output "gke_id" {
    value = google_container_cluster.primary.id
}

output "gke_name" {
    value = google_container_cluster.primary.name
}