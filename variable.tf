variable "project-id" {
  type    = string
  default = "ultra-airway-281611"
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "db_user" {
  type    = string
  default = "britetest-user"
}

variable "db_pass" {
  type    = string
  default = "britetest"
}

variable "db_table_name" {
  type    = string
  default = "omdb_movie_info"
}

variable "omdb_api_key" {
  type = string
}

variable "britetest_docker_image" {
  type    = string
  default = "srikanthreddypailla/learning:1.0.0"
}
