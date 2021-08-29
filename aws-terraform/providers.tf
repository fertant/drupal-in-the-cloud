# backend configured by command line options
# stub provider config required
terraform {
  required_version = ">= 0.13.1"
}

provider "aws" {
  region                  = var.region
  shared_credentials_file = "/Users/andrii/.aws/credentials"
  profile                 = "personal-account"
  # assume_role {
  #   role_arn     = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
  #   session_name = "SESSION_NAME"
  #   external_id  = "EXTERNAL_ID"
  # }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}
