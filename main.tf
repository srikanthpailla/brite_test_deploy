terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
  }
}

provider "google" {
  project     = var.project-id
  region      = var.region
  zone        = var.zone
  credentials = "./keys.json"
}


module "mysql" {
  source = "./mysql"
  region = var.region
}


module "brite" {
  source          = "./brite"
  region          = var.region
  project         = var.project-id
  db_pass         = var.db_pass
  omdb_api_key    = var.omdb_api_key
  mysql_conn_name = module.mysql.cloud_sql_instance_connection_name

  # create brite resources only after mysql instance is created
  depends_on = [module.mysql]
}
