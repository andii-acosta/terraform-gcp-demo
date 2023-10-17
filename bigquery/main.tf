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
############# CREAR DATA SET BIGQUERY ##########################################
resource "google_bigquery_dataset" "dataset-ob" {
  dataset_id    = "con_openbanking_data"
  friendly_name = "datos dominio openbanking"
  description   = "datos dominio openbanking"
  location      = "EU"

  labels = {
    dominio = "openbanking"
  }

  access {
    role          = "OWNER"
    user_by_email = "minimal-rols-apis@ci-cd-andres.iam.gserviceaccount.com"
  }
}

################################################################################
############# CREAR TABLA BASE BIGQUERY ########################################
resource "google_bigquery_table" "table-origin-openbanking" {
  dataset_id          = google_bigquery_dataset.dataset-ob.dataset_id
  table_id            = "mon_tx_ctas"
  deletion_protection = false

  time_partitioning {
    type = "DAY"
  }

  labels = {
    dominio = "openbanking"
  }

  schema = <<EOF
[
  {
    "name": "COD_TIPO_IDENTIFICACION",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "codigo tipo documento"
  },
  {
    "name": "NRO_IDENTIFICACION",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Numero de identificacion del cliente"
  },
  {
    "name": "COD_TRANSACCION",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Codigo unico de la transaccion"
  },
  {
    "name": "DESCRIPCION_MOTIVO_CONCEPTO",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "motivo concepto"
  },
  {
    "name": "DESCRIPCION_CANAL_TRANSACCION",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Descripcion del canal"
  },
  {
    "name": "COD_TIPO_MOVIMIENTO",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "tipo movimiento codigo"
  },
  {
    "name": "FECHA_TRANSACCION",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "fecha cliente realiza transaccion"
  },
  {
    "name": "FECHA_LIQUIDACION",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "fecha aplicacion del movimiento"
  },
  {
    "name": "COD_BANCO_TX",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "codigo identificador del banco"
  },
  {
    "name": "MONTO_TOTAL",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "monto valor transaccion"
  },
  {
    "name": "COD_TIPO_MONEDA",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "tipo moneda codigo"
  },
  {
    "name": "COD_ACTIVIDAD_ECONOMICA",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "actividad economica"
  }
]
EOF
}
