#-------------------------------------------------------------
# Generic base security groups which may be useful
#-------------------------------------------------------------
resource "aws_security_group" "http_from_epam" {
  name        = "http_from_epam"
  description = "Allow inbound HTTP from EPAM IP ranges"
  vpc_id      = "${aws_vpc.main.id}"

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "security_group_http_from_epam"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "security_group_http_from_epam",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"
}

resource "aws_security_group_rule" "allow_http_from_epam" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${split(",", var.global_epam_cidr_blocks)}"]
  security_group_id = "${aws_security_group.http_from_epam.id}"
}

resource "aws_security_group" "https_from_epam" {
  name        = "https_from_epam"
  description = "Allow inbound HTTPS from EPAM IP ranges"
  vpc_id      = "${aws_vpc.main.id}"

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "security_group_https_from_epam"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "security_group_https_from_epam",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"
}

resource "aws_security_group_rule" "allow_https_from_epam" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["${split(",", var.global_epam_cidr_blocks)}"]
  security_group_id = "${aws_security_group.https_from_epam.id}"
}
