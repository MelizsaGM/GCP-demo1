#subnet
module "vpc" {
  source = "terraform-google-modules/network/google//modules/subnets"

  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = var.subnet_name
      subnet_ip     = "10.26.4.0/24" //"10.128.0.0/20"
      subnet_region = var.region
    }
  ]

  secondary_ranges = {
    (var.subnet_name) = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
    ]

    subnet-02 = []
  }
  depends_on = [google_compute_network.vpc_network]
}

#Firewall
module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = var.network_name

  rules = [{
    name                    = "demo1-allow-ssh"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22", "80", "8080", "1000-2000"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
  depends_on = [google_compute_network.vpc_network]
}

#network
resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = var.auto_create_subnetworks
}
