#creates subscription

resource "google_pubsub_topic" "demo1" {
  name = "demo1-topic"
}

resource "google_pubsub_subscription" "demo1" {
  name  = "demo1-subscription"
  topic = google_pubsub_topic.demo1.name
}