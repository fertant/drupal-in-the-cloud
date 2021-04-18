module "sql-db" {
  source  = "./modules/mysql"
  project_id                      = var.gcp_project
  name                            = var.db_name
  random_instance_name            = var.random_instance_name
  database_version                = var.db_version
  region                          = var.gcp_region
  zone                            = var.zone[0]
  tier                            = var.db_tier
  activation_policy               = var.activation_policy
  availability_type               = var.availability_type
  disk_autoresize                 = var.disk_autoresize
  disk_size                       = var.disk_size
  disk_type                       = var.disk_type
  pricing_plan                    = var.pricing_plan
  maintenance_window_day          = var.maintenance_window_day
  maintenance_window_hour         = var.maintenance_window_hour
  maintenance_window_update_track = var.maintenance_window_update_track
  database_flags                  = var.database_flags
  encryption_key_name             = var.encryption_key_name

  deletion_protection = var.deletion_protection

  user_labels = var.user_labels

  backup_configuration = var.backup_configuration

  ip_configuration = {
    ipv4_enabled = var.assign_public_ip
    # We never set authorized networks, we need all connections via the
    # public IP to be mediated by Cloud SQL.
    authorized_networks = []
    require_ssl         = true
    private_network     = "projects/${var.gcp_project}/global/networks/${var.vpc_name}"
  }

  db_name      = var.db_name
  db_charset   = var.db_charset
  db_collation = var.db_collation

  additional_databases = var.additional_databases
  user_name            = var.user_name

  // All MySQL users can connect only via the Cloud SQL Proxy.
  user_host = "cloudsqlproxy~%"

  user_password    = var.user_password
  additional_users = var.additional_users

  // Read replica
  read_replica_name_suffix         = var.read_replica_name_suffix
  read_replica_deletion_protection = var.read_replica_deletion_protection
  read_replicas                    = local.read_replicas

  create_timeout    = var.create_timeout
  update_timeout    = var.update_timeout
  delete_timeout    = var.delete_timeout

  depends_on = [google_service_networking_connection.private_network_connection]
}