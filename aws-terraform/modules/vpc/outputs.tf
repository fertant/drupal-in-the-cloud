output "nat_eips" {
  value = "${join(",", aws_eip.nat.*.public_ip)}"
}

output "inbound_http_security_group" {
  value = "${aws_security_group.http_from_epam.id}"
}

output "inbound_https_security_group" {
  value = "${aws_security_group.https_from_epam.id}"
}

output "phz_zone_id" {
  value = "${aws_route53_zone.vpc_private_zone.zone_id}"
}

output "phz_zone_name" {
  value = "${var.global_phz_domain}"
}

output "private_route_table" {
  value = "${join(",", aws_route_table.private_route_table.*.id)}"
}

output "public_route_table" {
  value = "${join(",", aws_route_table.public_route_table.*.id)}"
}

output "public_subnets" {
  value = "${join(",", aws_subnet.public_subnets.*.id)}"
}

output "private_subnets" {
  value = "${join(",", aws_subnet.private_subnets.*.id)}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}

output "nat_ids" {
  value = "${join(",", aws_nat_gateway.nat.*.id)}"
}

output "nat_ids_list" {
  value = ["${aws_nat_gateway.nat.*.id}"]
}
