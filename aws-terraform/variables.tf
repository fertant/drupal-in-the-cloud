#-----------------------------------------------
#   Resource tagging Variables
#-----------------------------------------------

variable "environment" {
  description = "Deploying Environment"
  type        = string
  default     = ""
}

variable "product" {
  description = "Name of the product"
  type        = string
  default     = ""
}

variable "sub_product" {
  description = "Name of the product"
  type        = string
  default     = ""
}

variable "contact" {
  description = "Any valid support group email address."
  type        = string
  default     = ""
}

variable "cost_code" {
  description = "Various costing sources: cost center, project code, PnL budget."
  type        = string
  default     = ""
}

variable "orchestration" {
  description = "Path to the Git control repository."
  type        = string
  default     = ""
}

variable "role" {
  description = "Role to be assigned. Must not contain hyphens"
  type        = string
  default     = ""
}

variable "description" {
  description = "What is this thing? What does it do? Multiple words separated by '_'"
  type        = string
  default     = ""
}

#-----------------------------------------------
#   VPC Variables
#-----------------------------------------------

variable "vpc_name" {
  description = "Terraform state VPC name."
  default     = ""
}

variable "vpc_subnet_cidr" {
  description = "The subnet of the VPC being created in CIDR format"
}

variable "availability_zones" {
  description = "The AZs that the VPC will use"
  type        = list(string)
  default     = [
    "eu-west-3a",
    "eu-west-3b",
    "eu-west-3c"
  ]
}

variable "public_subnets" {
  description = "The CIDR blocks to be used for the public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "The CIDR blocks to be used for the private subnets"
  type        = list(string)
}

variable "region" {
  default = "eu-west-3"
}

variable "cluster_name" {
  default = "jd-eks-cluster"
}

variable instance_types {
  description = "Set of instance types associated with the EKS Node Group"
  type        = string
  default     = "t3.medium"
}

variable desired_capacity {
  description = "Desired number of worker nodes."
  type        = number
  default     = 1
}

variable min_capacity {
  description = "Minimum number of worker nodes."
  type        = number
  default     = 1
}

variable max_capacity {
  description = "Maximum number of worker nodes."
  type        = number
  default     = 1
}

variable ami_type {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group."
  type        = string
  default     = "AL2_x86_64"
}

variable disk_size {
  description = "Disk size in GiB for worker nodes."
  type        = string
  default     = "20"
}

variable capacity_type {
  description = "Type of capacity associated with the EKS Node Group."
  type        = string
  default     = "SPOT"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
