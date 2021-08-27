# vpc Module

## Overview

A Terraform module to create a new VPC and the support infrastructure. The full list of resources:

 - A new VPC
 - Public and private subnets as defined in input variables
 - Route tables for subnets
 - Generic security groups
 - Route53 Private Hosted Zone
 - Network ACLs to provide stateless filtering at the VPC boundary.
 - Elastic IPs and Managed NAT gateway devices for each Availability Zone

## Dependencies
 - rap-terraform-account-bootstrap (separate terraform run)
 - New AWS accounts should have the Rules Per Network ACL limit raised from the default limit of 20 to 40. This can be done via a standard support request.

## Usage
To import the module add the following to the environment main.tf file:
```
module "vpc" {
  source = "<path_to_module>"

  vpc_name              = "${var.vpc_name}"
  vpc_subnet            = "${var.vpc_subnet_cidr}"
  vpc_tag_product       = "${var.vpc_tag_product}"
  vpc_tag_sub_product   = "${var.vpc_tag_sub_product}"
  vpc_tag_contact       = "${var.vpc_tag_contact}"
  vpc_tag_cost_code     = "${var.vpc_tag_cost_code}"
  vpc_tag_environment   = "${var.vpc_tag_environment}"
  vpc_tag_orchestration = "${var.vpc_tag_orchestration}"
  vpc_tag_description   = "${var.vpc_tag_description}"


  global_private_subnets      = "${var.global_private_subnets}"
  global_public_subnets       = "${var.global_public_subnets}"
  global_availability_zones   = "${var.global_availability_zones}"
  global_epam_cidr_blocks = "${var.global_epam_cidr_blocks}"
}
```

## Variables
### Required
 - `vpc_subnet` - The subnet of the VPC being created.
 - `vpc_name` - The name of the VPC being created.
 - `global_epam_cidr_blocks` - List of EPAM CIDR blocks for NACLs to use.
 - `global_availability_zones` - The AZs that the VPC will use.
 - `global_public_subnets` - The CIDR blocks to be used for the public subnets.
 - `global_private_subnets` - The CIDR blocks to be used for the private subnets.
 - `vpc_tag_product` - Assigned in design phase. Is likely to span multiple AWS accounts.
 - `vpc_tag_sub_product` - Assigned in design phase. Used where an AWS account runs more than one service.
 - `vpc_tag_contact` - Specifies the group email address of the team responsible for the support of this resource.
 - `vpc_tag_cost_code` - Track costs to align with various costing sources: cost centre, project code, PnL budget."
 - `vpc_tag_environment` - Environment consists of 2 segments, separated by a dash. First segment: environment category (prod, dev or test). Second segment: Free form name to further describe the function of the environment.
 - `vpc_tag_orchestration` - Path to Git for control repository.
 - `vpc_tag_description` - A tag to describe what the resource is/does, such as the applications it runs.

### Optional
 - `global_phz_domain` - The private hosted zone domain name. Default is els.vpc.local.
 - `vpc_virtual_private_gateway` - The virtual private gateway id to propagate through the routing tables. Default is an empty string - "".
 - `vpc_additional_tags` - A map of additional tag/value pairs to add to the vpc tags.

## Outputs
 - `nat_eips`
 - `public_subnets`
 - `private_subnets`
 - `vpc_id`
 - `inbound_http_security_group`
 - `inbound_https_security_group`
 - `phz_zone_id`
 - `phz_zone_name`
 - `nat_ids`
 - `nat_ids_list`

## Network ACLs
### Private Subnets ACL
All traffic on the private/internal subnets is allowed. One of the main
reasons for operating a Public/Private network setup, with a dedicated
Bastion host, is so that private traffic can be as permissive as is
necessary.

Assume that all rules are for TCP traffic, unless noted otherwise.

### Public Subnets ACL

#### Ingress (inbound) Allowed
- `100` - Port 80 (HTTP) from anywhere.
- `200` - Port 443 (HTTPS) from anywhere.
- `300` - ICMP from anywhere.
- `350` - Port 123 UDP (NTP) from anywhere.
- `400` - Port 1024-65535 from VPC.
Requirement for SSH dynamic port assignment to work.
- `500` - Port 22 (SSH) from EPAM offices (specifically required for London, Miamisburg and Oxford).
- `600` - Port 22 (SSH) from EPAM VPN.
- `700` - Port 22 (SSH) from Mendeley VPN.
- `800` - Port 22 (SSH) from the Private subnet.
- `810` - Port 465 (SMTPS) from anywhere.
- `820` - Port 587 (ESMTP) from anywhere.
- `1400` - Port 1024-65535 from anywhere.

#### Ingress (inbound) Blocked
- `900` - Port 3389 (RDP) from anywhere.
- `1000` - Port 1433 (SQL Server) from anywhere.
- `1100` - Port 3306 (MySQL)from anywhere.
- `1200` - Port 5432 (PostgreSQL)from anywhere.
- `1300` - Port 2483-2484 (Oracle) from anywhere.

#### Egress (outbound)
- `100` - Port 1024-65535 to anywhere. Requirement for SSH dynamic port assignment to work.
- `200` - Port 80 (HTTP) to anywhere.
- `300` - Port 443 (HTTPS) to anywhere.
- `400` - Port 22 (SSH) to the VPC subnet.
- `500` - ICMP to anywhere.
- `550` - Port 123 UDP (NTP) to anywhere.
- `600` - Port 22 (SSH) to gitlab.et-scm.com.
- `700` - Port 22 (SSH) to anywhere.
- `800` - Port 465 (SMTPS) to anywhere.
- `900` - Port 587 (ESMTP) to anywhere.
