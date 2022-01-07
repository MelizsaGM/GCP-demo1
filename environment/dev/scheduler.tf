#creates scheduler/cron job publish a message into pubsub
resource "google_cloud_scheduler_job" "job" {
  name        = "demotask-job"
  description = "demo test job"
  schedule    = "* * * * *" #Runs every minute
  time_zone   = "America/Mexico_City"


  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.demo1.id
    data       = base64encode("test")
  }

  depends_on = [google_project_service.project, google_app_engine_application.app]
}