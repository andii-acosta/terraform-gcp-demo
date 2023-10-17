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
############# CREAR INSTANCIA SQL            ###################################
resource "google_sql_database_instance" "postgres_pvp_instance_fastdata" {
  name             = "postgres-pvp-instance-fastdata"
  region           = "us-central1"
  database_version = "POSTGRES_14"
  root_password    = "123456"
  settings {
    activation_policy     = "ALWAYS"
    availability_type     = "ZONAL"
    disk_autoresize       = false
    disk_autoresize_limit = 0
    disk_size             = "20"
    disk_type             = "PD_HDD"
    pricing_plan          = "PER_USE"
    tier                  = "db-custom-1-3840"
  }
  # set `deletion_protection` to true, will ensure that one cannot accidentally delete this instance by
  # use of Terraform whereas `deletion_protection_enabled` flag protects this instance at the GCP level.
  deletion_protection = false
}

################################################################################
############# CREAR BASE DE DATOS ###################################
resource "google_sql_database" "database-ob" {
  name     = "transactionaldata"
  instance = google_sql_database_instance.postgres_pvp_instance_fastdata.name
}