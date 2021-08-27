module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.gcp_project
  name                       = "gke-drupal"
  region                     = var.gcp_region
  zones                      = var.zone
  network                    = var.vpc_name
  subnetwork                 = local.network_subnet_01
  ip_range_pods              = "cluster_ipv4_cidr_block"
  ip_range_services          = "services_ipv4_cidr_block"
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = true

  node_pools = [
    {
      name               = "drupal-node-pool"
      machine_type       = "e2-medium"
      node_locations     = join(", ", var.zone)
      min_count          = 1
      max_count          = 3
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "603521150873-compute@developer.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
