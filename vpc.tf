module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id   = var.gcp_project
  network_name = var.vpc_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = local.network_subnet_01
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = local.network_subnet_02
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = local.network_subnet_03
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
  ]

    routes = local.network_routes
}