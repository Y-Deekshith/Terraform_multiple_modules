output "name" {
    value = aws_vpc.modulevpc1.tags.Name
}

output "vpc_id" {
    value = aws_vpc.modulevpc1.id
}

output "vpc_env" {
    value = aws_vpc.modulevpc1.tags.Env
}