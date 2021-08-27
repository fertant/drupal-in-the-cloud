# GCP Settings
gcp_project = "cobalt-academy-243620"
gcp_region  = "us-central1"
zone        = ["us-central1-a", "us-central1-b", "us-central1-c"]

# Bucket
state_bucket_name   = "drupalcloud-global" 
basic_storage_class = "REGIONAL"

#VPC
vpc_name     = "us-central-vpc"
network_name = "drupal-network"
subnet_ip_addresses = ["10.10.10.0/24","10.10.30.0/24"]

# SQL
db_name    = "drupal-master-db"
db_tier    = "db-n1-standard-1"
db_version = "MYSQL_5_7"
