
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service#example-usage---cloudrunv2-service-sql
resource "google_cloud_run_v2_service" "cloudrun-service-brite" {
  name     = "cloudrun-service-brite"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = ["${var.mysql_conn_name}"]
      }
    }

    containers {
      image = "srikanthreddypailla/learning:britetest1"
      ports {
        container_port = 8000
      }
      env {
        name  = "DB_PASS"
        value = var.db_pass
      }
      env {
        name  = "INSTANCE_UNIX_SOCKET"
        value = "/cloudsql/${var.project}:${var.region}:britetest-instance"
      }
      env {
        name  = "OMDB_API_KEY"
        value = var.omdb_api_key
      }
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# allow unauthenticated invocations for public API or website
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_v2_service.cloudrun-service-brite.location
  project  = google_cloud_run_v2_service.cloudrun-service-brite.project
  service  = google_cloud_run_v2_service.cloudrun-service-brite.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
