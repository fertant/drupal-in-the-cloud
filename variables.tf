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
