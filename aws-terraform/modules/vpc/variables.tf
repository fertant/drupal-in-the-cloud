variable "all_cidr_blocks" {
  description = "Entire CIDR block range"
  default     = "0.0.0.0/0"
}

variable "vpc_subnet" {
  description = "The subnet of the VPC being created in CIDR format"
}

variable "vpc_name" {
  description = "The name of the VPC being created"
}

variable "global_epam_cidr_blocks" {
  description = "List of EPAM CIDR blocks for NACLs to use"
}

variable "global_phz_domain" {
  description = "The private hosted zone domain name"
  default     = "els.vpc.local"
}

variable "global_availability_zones" {
  description = "The AZs that the VPC will use"
}

variable "global_public_subnets" {
  description = "The CIDR blocks to be used for the public subnets"
}

variable "global_private_subnets" {
  description = "The CIDR blocks to be used for the private subnets"
}

variable "vpc_virtual_private_gateway" {
  description = "The virtual private gateway id to propagate through the routing tables"
  default     = ""
}

#--------------------------------------------------------------
# VPC Tag Variables
#--------------------------------------------------------------
variable "vpc_tag_product" {
  description = "Assigned in design phase. Is likely to span multiple AWS accounts."
  type        = "string"
}

variable "vpc_tag_sub_product" {
  description = "Assigned in design phase. Used where an AWS account runs more than one service."
  type        = "string"
}

variable "vpc_tag_contact" {
  description = "Specifies the group email address of the team responsible for the support of this resource."
  type        = "string"
}

variable "vpc_tag_cost_code" {
  description = "Track costs to align with various costing sources: cost centre, project code, PnL budget."
  type        = "string"
}

variable "vpc_tag_environment" {
  description = "Environment consists of 2 segments, separated by a dash. First segment: environment category (prod, dev or test). Second segment: Free form name to further describe the function of the environment."
  type        = "string"
}

variable "vpc_tag_orchestration" {
  description = "Path to Git for control repository."
  type        = "string"
}

variable "vpc_tag_description" {
  description = "A tag to describe what the resource is/does, such as the applications it runs."
  type        = "string"
}

variable "vpc_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the VPC."
  type        = "map"
  default     = {}
}
