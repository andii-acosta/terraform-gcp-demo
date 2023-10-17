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

################################################################################
############# CREAR TOPICO PARA ACTIVAR FUNC ###################################
#Se crea el TOPICO para activar la cloud function
resource "google_pubsub_topic" "ingest-data-ob" {
  name    = "active-function-ob"
  project = "ci-cd-andres"

  labels = {
    dominio = "openbanking"
  }

  message_retention_duration = "86600s"
}

#Se crea el suscriptor para el topico
resource "google_pubsub_subscription" "sub-ingest-data-ob" {
  name  = "sub-active-function-ob"
  topic = google_pubsub_topic.ingest-data-ob.name

  ack_deadline_seconds = 20

  labels = {
    dominio = "openbanking"
  }
}