#--------------------------------------------------------------
# Internet Gateway
#--------------------------------------------------------------
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(map("Name","${join(".",list(var.vpc_tag_product, var.vpc_tag_environment, "internet_gateway"))}",
                      "Product","${var.vpc_tag_product}",
                      "SubProduct", "${var.vpc_tag_sub_product}",
                      "Contact", "${var.vpc_tag_contact}",
                      "CostCode", "${var.vpc_tag_cost_code}",
                      "Environment", "${var.vpc_tag_environment}",
                      "Description", "internet_gateway",
                      "Orchestration", "${var.vpc_tag_orchestration}"),
                  var.vpc_additional_tags)}"
}
