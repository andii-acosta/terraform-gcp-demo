terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.38.0"
    }
  }
}

provider "google" {
  project = "ci-cd-andres"
  region  = "us-central1"
}


resource "google_storage_bucket" "storage-df-ob" {
  name          = "df-openbank"
  location      = "US"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}