inputs = {
  project_id = "gcpdemo-task1"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
  terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "4.5.0"
      }
    }
  }
    provider "google" {
      project = "gcpdemo-task1"
      region  = "us-central1"
    }
  EOF
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "demo-task1-22"
    prefix  = "${path_relative_to_include()}/terraform.tfstate"
    project = "gcpdemo-task1"
  }
}