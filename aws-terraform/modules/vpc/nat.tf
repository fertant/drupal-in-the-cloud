#--------------------------------------------------------------
# Managed NAT Gateways
#--------------------------------------------------------------
resource "aws_eip" "nat" {
  count = "${length(split(",", var.global_public_subnets))}"
  vpc   = true
}

resource "aws_nat_gateway" "nat" {
  count         = "${length(split(",", var.global_public_subnets))}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  depends_on    = ["aws_internet_gateway.gw"]
}
