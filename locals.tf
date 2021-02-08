locals {
  network_subnet_01 = "${var.network_name}-subnet-01"
  network_subnet_02 = "${var.network_name}-subnet-02"
  network_subnet_03 = "${var.network_name}-subnet-03"

  network_routes = [
    {
      name              = "${var.network_name}-egress-inet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },
  ]
}