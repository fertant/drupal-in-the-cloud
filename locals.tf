locals {
  network_subnet_01 = "${var.network_name}-subnet-01"
  network_subnet_02 = "${var.network_name}-subnet-02"
  network_subnet_03 = "${var.network_name}-subnet-03"
  network_subnet_04 = "${var.network_name}-subnet-04"

  network_routes = [
    {
      name              = "${var.network_name}-egress-inet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },
  ]

  firewall_rules = {
    // Example of custom tcp/udp rule
    deny-ingress-6534-6566 = {
      description          = "Deny all INGRESS to port 6534-6566"
      direction            = "INGRESS"
      action               = "deny"
      ranges               = ["0.0.0.0/0"] # source or destination ranges (depends on `direction`)
      use_service_accounts = false         # if `true` targets/sources expect list of instances SA, if false - list of tags
      targets              = null          # target_service_accounts or target_tags depends on `use_service_accounts` value
      sources              = null          # source_service_accounts or source_tags depends on `use_service_accounts` value
      rules = [{
        protocol = "tcp"
        ports    = ["6534-6566"]
        },
        {
          protocol = "udp"
          ports    = ["6534-6566"]
      }]

      extra_attributes = {
        disabled = true
        priority = 95
      }
    }

    // Example how to allow connection from instances with `backend` tag, to instances with `databases` tag
    allow-backend-to-databases = {
      description          = "Allow backend nodes connection to databases instances"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = null
      use_service_accounts = false
      targets              = ["databases"] # target_tags
      sources              = ["backed"]    # source_tags
      rules = [{
        protocol = "tcp"
        ports    = ["3306", "5432", "1521", "1433"]
      }]

      extra_attributes = {}
    }

    // Example how to allow connection from an instance with a given service account
    allow-all-admin-sa = {
      description          = "Allow all traffic from admin sa instances"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = null
      use_service_accounts = true
      targets              = null
      sources              = ["admin@my-shiny-org.iam.gserviceaccount.com"]
      rules = [{
        protocol = "tcp"
        ports    = null # all ports
        },
        {
          protocol = "udp"
          ports    = null # all ports
        }
      ]
      extra_attributes = {
        priority = 30
      }
    }
  }

  read_replicas = [{
    name             = "drupal-db-replica"
    zone             = var.zone[1]
    tier             = var.db_tier
    ip_configuration = {
      ipv4_enabled    = var.assign_public_ip
      require_ssl     = true
      private_network = "projects/${var.gcp_project}/global/networks/${var.vpc_name}"
      authorized_networks = []
    }
    database_flags   = [{ name = "long_query_time", value = 1 }]
    disk_autoresize  = null
    disk_size        = null
    disk_type        = var.disk_type
    user_labels      = {}
  }]
}