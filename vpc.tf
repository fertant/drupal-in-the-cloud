module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id   = var.gcp_project
  network_name = var.vpc_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = local.network_subnet_01
      subnet_ip             = var.subnet_ip_addresses[0]
      subnet_region         = var.gcp_region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = local.network_subnet_03
      subnet_ip             = var.subnet_ip_addresses[1]
      subnet_region         = var.gcp_region
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
  ]

  //routes = local.network_routes
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"

  name    = "${var.vpc_name}-nat-router"
  project = var.gcp_project
  region  = var.gcp_region
  network = var.vpc_name

  nats = [{
    name = "${var.vpc_name}-nat"
  }]
}

module "dns-private-zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  project_id = var.gcp_project
  type       = "private"
  name       = var.dns_name
  domain     = var.private_domain
  labels     = var.dns_labels

  private_visibility_config_networks = [
    "https://www.googleapis.com/compute/v1/projects/cobalt-academy-243620/global/networks/us-central-vpc"
  ]

  recordsets = [
    {
      name    = "localhost"
      type    = "A"
      ttl     = 300
      records = [
        "127.0.0.1",
      ]
    },
  ]
}