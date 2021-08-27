module "firewall-rules" {
  source                  = "./modules/firewall"
  project_id              = var.gcp_project
  network                 = var.vpc_name
  internal_ranges_enabled = true
  internal_ranges         = module.vpc.subnets_ips

  internal_allow = [
    {
      protocol = "icmp"
    },
    {
      protocol = "tcp",
      ports    = ["8080", "1000-2000"]
    },
    {
      protocol = "udp"
      # all ports will be opened if `ports` key isn't specified
    },
  ]
  custom_rules = local.firewall_rules
}
