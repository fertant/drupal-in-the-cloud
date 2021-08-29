# backend configured by command line options
# stub provider config required
terraform {
  required_version = ">= 0.13"
  backend "gcs" {
    bucket      = "drupalcloud-global"
    prefix      = "tfstate/network-tfsate"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.57.0"
    }
  }    
}
