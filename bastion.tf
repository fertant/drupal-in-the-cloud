#module "iap_bastion" {
#  source = "terraform-google-modules/bastion-host/google"
#
#  project = var.gcp_project
#  zone    = var.zone[1]
#  network = module.vpc.network.network_name
#  subnet  = module.vpc.subnets.1.self_link
#  members = [
#    "user:shutovandrii@gmail.com",
#  ]
#}