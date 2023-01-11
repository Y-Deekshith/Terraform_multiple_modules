output "instance" {
    value = aws_instance.public_ec2.*.id
}
output "privateinstance" {
    value = aws_instance.private_ec2.*.id
}
