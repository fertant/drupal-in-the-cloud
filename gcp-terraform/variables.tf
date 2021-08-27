#-----------------------------------------------
#   Resource tagging Variables
#-----------------------------------------------

#variable "environment" {
#  description = "Deploying Environment"
#}
#
#variable "product" {
#  description = "Name of the product"
#}
#
#variable "sub_product" {
#  description = "Name of the product"
#}
#
#variable "contact" {
#  description = "Any valid support group email address."
#  type        = string
#}
#
#variable "cost_code" {
#  description = "Various costing sources: cost center, project code, PnL budget."
#  type        = string
#}
#
#variable "orchestration" {
#  description = "Path to the Git control repository."
#  type        = string
#}
#
#variable "role" {
#  description = "Role to be assigned. Must not contain hyphens"
#  type        = string
#}
#
#variable "description" {
#  description = "What is this thing? What does it do? Multiple words separated by '_'"
#  type        = string
#}

#-----------------------------------------------
#   VPC Variables
#-----------------------------------------------
variable "gcp_project" {
  description = "Project name."
  default     = "brilliant-rhino-303702"
}

variable "gcp_region" {
  description = "GCP deployment ragion."
  default     = "us-central1"
}

variable "state_bucket_name" {
  description = "Terraform state bucket name."
  default     = ""
}

variable "basic_storage_class" {
  description = "Basic bucket storage class."
  default     = "REGIONAL"
}

variable "vpc_name" {
  description = "Name of vpc."
  default     = ""
}

variable "network_name" {
  description = "Name of the network inside vpc."
  default     = ""
}

variable "subnet_ip_addresses" {
  description = "Subnet IP addresses"
  type        = list(string)
  default     = []
}

variable "zone" {
  description = "The zone for the master instance, it should be something like: `a`, `c`."
  type        = list(string)
  default     = [
    "us-central1-a",
    "us-central1-b"
  ]
}

variable "dns_name" {
  description = "DNS zone name."
  default     = "drupal-cloud-local"
}

variable "private_domain" {
  description = "Private DNS zone name."
  default     = "drupal-cloud.local."
}

variable "dns_labels" {
  type        = map
  description = "A set of key/value label pairs to assign to this ManagedZone"
  default = {
    project = "drupal_in_the_cloud"
  }
}

#-----------------------------------------------
#   DB Variables
#-----------------------------------------------
variable "db_name" {
  description = "The name of the Cloud SQL resources"
  type        = string
}

variable "random_instance_name" {
  type        = bool
  description = "Sets random suffix at the end of the Cloud SQL resource name"
  default     = false
}

// required
variable "db_version" {
  description = "The database version to use"
  type        = string
  default     = "MYSQL_5_7"
}

variable "db_tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-n1-standard-1"
}

variable "activation_policy" {
  description = "The activation policy for the master instance. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  type        = string
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "The availability type for the master instance. Can be either `REGIONAL` or `null`."
  type        = string
  default     = "REGIONAL"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "The disk size for the master instance"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The disk type for the master instance."
  type        = string
  default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "The pricing plan for the master instance."
  type        = string
  default     = "PER_USE"
}

variable "maintenance_window_day" {
  description = "The day of week (1-7) for the master instance maintenance."
  type        = number
  default     = 1
}

variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window for the master instance maintenance."
  type        = number
  default     = 23
}

variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance. Can be either `canary` or `stable`."
  type        = string
  default     = "stable"
}

variable "database_flags" {
  description = "The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/mysql/flags)"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "user_labels" {
  description = "The key/value labels for the master instances."
  type        = map(string)
  default     = {}
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  type = object({
    binary_log_enabled = bool
    enabled            = bool
    start_time         = string
    location           = string
  })
  default = {
    binary_log_enabled = true
    enabled            = true
    start_time         = "23:55"
    location           = null
  }
}

variable "assign_public_ip" {
  description = "Set to true if the master instance should also have a public IP (less secure)."
  type        = string
  default     = false
}

// Read Replicas
variable "read_replica_name_suffix" {
  description = "The optional suffix to add to the read instance name"
  type        = string
  default     = ""
}

variable "read_replicas" {
  description = "List of read replicas to create"
  type = list(object({
    name            = string
    tier            = string
    zone            = string
    disk_type       = string
    disk_autoresize = bool
    disk_size       = string
    user_labels     = map(string)
    database_flags = list(object({
      name  = string
      value = string
    }))
    ip_configuration = object({
      authorized_networks = list(map(string))
      ipv4_enabled        = bool
      private_network     = string
      require_ssl         = bool
    })
  }))
  default = []
}

variable "db_charset" {
  description = "The charset for the default database"
  type        = string
  default     = "utf8mb4"
}

variable "db_collation" {
  description = "The collation for the default database. Example: 'utf8_general_ci'"
  type        = string
  default     = "utf8mb4_general_ci"
}

variable "additional_databases" {
  description = "A list of databases to be created in your cluster"
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  default = []
}

variable "user_name" {
  description = "The name of the default user"
  type        = string
  default     = ""
}

variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  type        = string
  default     = ""
}

variable "additional_users" {
  description = "A list of users to be created in your cluster"
  type = list(object({
    name     = string
    password = string
    host     = string
  }))
  default = []
}

variable "create_timeout" {
  description = "The optional timout that is applied to limit long database creates."
  type        = string
  default     = "15m"
}

variable "update_timeout" {
  description = "The optional timout that is applied to limit long database updates."
  type        = string
  default     = "15m"
}

variable "delete_timeout" {
  description = "The optional timout that is applied to limit long database deletes."
  type        = string
  default     = "15m"
}

variable "module_depends_on" {
  description = "List of modules or resources this module depends on."
  type        = list(any)
  default     = []
}

variable "deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = false
}

variable "read_replica_deletion_protection" {
  description = "Used to block Terraform from deleting replica SQL Instances."
  type        = bool
  default     = false
}

variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption"
  type        = string
  default     = null
}