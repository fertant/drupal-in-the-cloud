# backend configured by command line options
# stub provider config required
terraform {
  required_version = ">= 0.14"
  backend "gcs" {
    bucket      = "drupalcloud-global"
    prefix      = "tfstate/network-tfsate"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.45.0"
    }
  }    
}

#provider "kubernetes" {
#  load_config_file       = false
#  host                   = "https://${module.gke.endpoint}"
#  token                  = data.google_client_config.default.access_token
#  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
#}