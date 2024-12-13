resource "aws_vpc" "main" {
  count = var.create_default_vpc ? 1 : 0

  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = false

  tags = {
    Name = "${local.resource_prefix}-vpc-${var.env}-${var.region_code}"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}
resource "aws_default_route_table" "main" {
  count = var.create_default_vpc ? 1 : 0
  default_route_table_id = one(aws_vpc.main.*.default_route_table_id)

  tags = {
    Name = "${local.resource_prefix}-rt-${var.env}-${var.region_code}-default"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}
resource "aws_default_vpc_dhcp_options" "default" {
 count = var.create_default_vpc ? 1 : 0
  tags = {
    Name = "${local.resource_prefix}-dhcp-${var.env}-${var.region_code}-default"
  }

  depends_on = [
    aws_vpc.main]
  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_default_network_acl" "default" {
  count = var.create_default_vpc ? 1 : 0
  default_network_acl_id = one(aws_vpc.main.*.default_network_acl_id)

  ingress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  egress {
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  tags = {
    Name = "${local.resource_prefix}-nacl-${var.env}-${var.region_code}-default"
  }
  lifecycle {
    ignore_changes = [
      tags,
      subnet_ids]
  }
}

resource "aws_default_security_group" "default" {
  count = var.create_default_vpc ? 1 : 0
  vpc_id = one(aws_vpc.main.*.id)

  tags = {
    Name = "${local.resource_prefix}-sg-${var.env}-${var.region_code}-default"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_internet_gateway" "main" {
  count = var.create_default_vpc ? 1 : 0
  vpc_id = one(aws_vpc.main.*.id)

  tags = {
    Name = "${local.resource_prefix}-igw-${var.env}-${var.region_code}"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

#### Endpoint ####
resource "aws_vpc_endpoint" "s3" {
  count = var.create_default_vpc ? 1 : 0
  vpc_id = one(aws_vpc.main.*.id)
  service_name = "com.amazonaws.ap-northeast-2.s3"
  vpc_endpoint_type = "Gateway"
  # Default "Gateway" ["Gateway", "Interface", "GatewayLoadBalancer"]
  # private_dns_enabled = false
  tags = {
    Name = "${local.resource_prefix}-vpce-${var.env}-s3-${var.region_code}"
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_vpc_endpoint_route_table_association" "ap" {
  count = var.create_default_vpc && length(var.ap_subnet_cidr_list) > 0 ? local.az_count : 0
  route_table_id = element(aws_route_table.ap.*.id, count.index)
  vpc_endpoint_id = one(aws_vpc_endpoint.s3.*.id)
}