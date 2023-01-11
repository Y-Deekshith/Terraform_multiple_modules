resource "aws_lb" "myalb" {
  name                       = "applb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_groups]
  subnets  = var.publicsubnet_cidr_block
  enable_deletion_protection = false
  tags = {
    Name        = var.name
    Environment = var.env
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "albtargetgp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}