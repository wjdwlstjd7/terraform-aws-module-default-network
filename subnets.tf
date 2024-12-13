resource "aws_subnet" "public" {
  count = var.create_default_vpc && length(var.public_subnet_cidr_list) > 0 ? local.az_count : 0

  vpc_id = one(aws_vpc.main.*.id)
  cidr_block = var.public_subnet_cidr_list[count.index]
  availability_zone = format("${var.region[var.region_code]}%s", element(var.azs, count.index))
  tags = {
    Name = format("${local.resource_prefix}-sbn-${local.resource_suffix}%s-pub", element(var.azs, count.index))
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}

#### private_subnet ####
resource "aws_subnet" "ap" {
  count = var.create_default_vpc && length(var.ap_subnet_cidr_list) > 0 ? local.az_count : 0

  cidr_block = var.ap_subnet_cidr_list[count.index]
  availability_zone = "${var.region[var.region_code]}${var.azs[count.index]}"
  vpc_id = one(aws_vpc.main.*.id)
  tags = {
    Name = format("${local.resource_prefix}-sbn-${local.resource_suffix}%s-ap", element(var.azs, count.index))
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}
resource "aws_subnet" "db" {
  count = var.create_default_vpc && length(var.db_subnet_cidr_list) > 0 ? local.az_count : 0

  cidr_block = var.db_subnet_cidr_list[count.index]
  availability_zone = "${var.region[var.region_code]}${var.azs[count.index]}"
  vpc_id = one(aws_vpc.main.*.id)
  tags = {
    Name = format("${local.resource_prefix}-sbn-${local.resource_suffix}%s-db", element(var.azs, count.index))
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}
resource "aws_subnet" "attach" {
  count = var.create_default_vpc && length(var.attach_subnet_cidr_list) > 0 ? local.az_count : 0

  cidr_block = var.attach_subnet_cidr_list[count.index]
  availability_zone = "${var.region[var.region_code]}${var.azs[count.index]}"
  vpc_id = one(aws_vpc.main.*.id)
  tags = {
    Name = format("${local.resource_prefix}-sbn-${local.resource_suffix}%s-attach", element(var.azs, count.index))
  }
  lifecycle {
    ignore_changes = [
      tags]
  }
}