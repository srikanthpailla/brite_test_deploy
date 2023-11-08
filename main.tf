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

