#--------------------------------------------------------------
# Public subnet resource definition
#--------------------------------------------------------------
resource "aws_subnet" "public_subnets" {
  count                   = "${length(split(",", var.global_public_subnets))}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(split(",", var.global_public_subnets), count.index)}"
  availability_zone       = "${element(split(",", var.global_availability_zones), count.index)}"
  map_public_ip_on_launch = true

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "public_subnet"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "public_subnet",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"

  lifecycle {
    create_before_destroy = true
  }
}

#--------------------------------------------------------------
# Private subnet resource definition
#--------------------------------------------------------------
resource "aws_subnet" "private_subnets" {
  count                   = "${length(split(",", var.global_private_subnets))}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(split(",", var.global_private_subnets), count.index)}"
  availability_zone       = "${element(split(",", var.global_availability_zones), count.index)}"
  map_public_ip_on_launch = false

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "private_subnet"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "private_subnet",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"

  lifecycle {
    create_before_destroy = true
  }
}
