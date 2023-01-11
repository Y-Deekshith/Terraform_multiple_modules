resource "aws_instance" "public_ec2" {
  count                       = var.env == "development" ? 2 : 1
  instance_type               = var.instancetype
  ami                         = var.ami
  subnet_id                   = element(var.publicsubnet_cidr_block, count.index)
  vpc_security_group_ids      = [var.security_group]
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags = {
    Name = "${var.name}-public_ec2-${count.index + 1}"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt-get install -y nginx jq
  sudo git clone -b publicserverpages https://github.com/Y-Deekshith/Terraform_multiple_modules.git deekshith
  cd deekshith
  sudo cp index.html /var/www/html/index.nginx-debian.html
  sudo rm index.html
  sudo mv * /var/www/html/
  sudo service nginx restart
  EOF
}
resource "aws_instance" "private_ec2" {
  count                       = var.env == "development" ? 1 : 2
  instance_type               = var.instancetype
  ami                         = var.ami
  subnet_id                   = element(var.privatesubnet_cidr_block, count.index)
  vpc_security_group_ids      = [var.security_group]
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags = {
    Name = "${var.name}-private_ec2-${count.index + 1}"
  }
  depends_on = [var.private_ec2_depends_on]
}