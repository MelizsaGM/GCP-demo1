variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  default     = "gcpdemo-task1"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "network_name" {
  description = "The name of the network being created"
  default     = "demo-network1"
}

variable "subnet_name" {
  description = "The name of the network being created"
  default     = "demo-subnetwork"
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}
