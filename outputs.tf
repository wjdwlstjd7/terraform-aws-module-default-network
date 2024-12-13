# Network outputs
output "vpc_id" {
  value = aws_vpc.main.*.id
}
output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}
output "ap_subnet_ids" {
  value = aws_subnet.ap.*.id
}
output "db_subnet_ids" {
  value = aws_subnet.db.*.id
}
output "attach_subnet_ids" {
  value = aws_subnet.attach.*.id
}
output "ap_route_table" {
  value = aws_route_table.ap.*.id
}
output "db_route_table" {
  value = aws_route_table.db.*.id
}
output "azs" {
  value = var.azs
}
output "create_default_vpc" {
  value = var.create_default_vpc
} 