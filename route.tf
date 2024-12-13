#### Public route_table ####
resource "aws_route_table" "public" {
  count = var.create_default_vpc ? 1 : 0
  vpc_id = one(aws_vpc.main.*.id)
  depends_on = [
    aws_internet_gateway.main]
  tags = merge(local.tags, {
    Name = "${local.resource_prefix}-rt-${local.resource_suffix}-public"
  })
  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_route" "public_internet_gateway" {
  count = var.create_default_vpc ? 1 : 0
  route_table_id = one(aws_route_table.public.*.id)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = one(aws_internet_gateway.main.*.id)
}

#### Private route_table ####
resource "aws_route_table" "ap" {
  count = var.create_default_vpc && length(var.ap_subnet_cidr_list) > 0 ? local.az_count : 0
  vpc_id = one(aws_vpc.main.*.id)
  tags = merge(local.tags, {
    Name = format("${local.resource_prefix}-rt-${local.resource_suffix}%s-ap", element(var.azs, count.index))
  })
  lifecycle {
    ignore_changes = [
      tags]
  }
}
resource "aws_route_table" "db" {
  count = var.create_default_vpc && length(var.db_subnet_cidr_list) > 0 ? local.az_count : 0
  vpc_id = one(aws_vpc.main.*.id)
  tags = merge(local.tags, {
    Name = format("${local.resource_prefix}-rt-${local.resource_suffix}%s-db", element(var.azs, count.index))
  })
  lifecycle {
    ignore_changes = [
      tags]
  }
}

#### Route table association ####
resource "aws_route_table_association" "public" {
  count = var.create_default_vpc && length(var.public_subnet_cidr_list) > 0 ? local.az_count : 0
  subnet_id = element(aws_subnet.public.*.id, count.index)
  route_table_id = one(aws_route_table.public.*.id)
}

resource "aws_route_table_association" "ap" {
  count = var.create_default_vpc && length(var.ap_subnet_cidr_list) > 0 ? local.az_count : 0
  subnet_id = element(aws_subnet.ap.*.id, count.index)
  route_table_id = element(aws_route_table.ap.*.id, count.index)
}

resource "aws_route_table_association" "db" {
  count = var.create_default_vpc && length(var.db_subnet_cidr_list) > 0 ? local.az_count : 0
  subnet_id = element(aws_subnet.db.*.id, count.index)
  route_table_id = element(aws_route_table.db.*.id, count.index)
}