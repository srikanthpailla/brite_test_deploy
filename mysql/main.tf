# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance#example-usage
resource "google_sql_database_instance" "britetest-instance" {
  name             = "britetest-instance"
  region           = var.region
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = "false"
}

resource "google_sql_database" "britetest-database" {
  name     = "britetest-database"
  instance = google_sql_database_instance.britetest-instance.name
}

resource "google_sql_user" "britetest-user" {
  name     = "britetest-user"
  instance = google_sql_database_instance.britetest-instance.name
  password = "britetest"
}

output "cloud_sql_instance_connection_name" {
  value = google_sql_database_instance.britetest-instance.connection_name
}
