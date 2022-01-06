resource "google_compute_instance" "vm_instance" {
  name         = "demo-instance-1"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
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

  depends_on = [module.vpc]#[google_compute_network.vpc_network]
}