//Enables scheduler service
resource "google_project_service" "project" {
  project = "gcpdemo-task1"
  service = "cloudscheduler.googleapis.com"

  disable_on_destroy = false
}