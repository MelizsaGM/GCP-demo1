resource "google_service_account" "default" {
  project      = var.project_id
  account_id   = "saccount-gcloud"
  display_name = "Service Account"
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "demo-instance-1"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  service_account {
    #creates a service account to manage gcloud commands
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  //Creates VM under customer subnetwork
  network_interface {
    subnetwork = var.subnet_name
    access_config {
      //assigns a public
    }
  }

  metadata = {
    startup-script = file("${path.module}/startup.sh")
  }

  depends_on = [module.vpc, google_service_account.default, google_project_iam_member.project] #[google_compute_network.vpc_network]
}