output "public_subnet_list" {
  value = aws_subnet.modulepublic_subnets.*.id
}
output "private_subnet_list" {
  value = aws_subnet.moduleprivate_subnets.*.id
}
output "public_subnet_list_1" {
  value = aws_subnet.modulepublic_subnets.0.id
}