#--------------------------------------------------------------
# Private Hosted Forward Lookup Zone
#--------------------------------------------------------------
resource "aws_route53_zone" "vpc_private_zone" {
  name   = "${var.global_phz_domain}"
  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "route53_private_zone"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "route53_private_zone",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"
}

#--------------------------------------------------------------
# Private Hosted Reverse Lookup Zone
#--------------------------------------------------------------
resource "aws_route53_zone" "reverse_lookup_zone" {
  name   = "${element(split(".", var.vpc_subnet),1)}.${element(split(".", var.vpc_subnet),0)}.in-addr.arpa"
  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "route53_reverse_lookup_zone"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "route53_reverse_lookup_zone",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"
}

#--------------------------------------------------------------
# Custom DHCP Option Set
#--------------------------------------------------------------
resource "aws_vpc_dhcp_options" "tio_options" {
  domain_name         = "${var.global_phz_domain}"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "vpc_dhcp"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "vpc_dhcp",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"
}

#--------------------------------------------------------------
# Association Between VPC and Custom DHCP Option Set
#--------------------------------------------------------------
resource "aws_vpc_dhcp_options_association" "local_resolver" {
  vpc_id          = "${aws_vpc.main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.tio_options.id}"
}
