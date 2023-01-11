resource "aws_lb" "myalb" {
  name                       = "applb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.security_groups]
  subnets                    = var.publicsubnet_cidr_block
  enable_deletion_protection = false
  tags = {
    Name        = var.name
    Environment = var.env
  }
}

resource "aws_lb_target_group" "alb_tg" {
  health_check {
    interval            = 10
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "albtargetgp"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
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

resource "aws_lb_target_group_attachment" "ec2_attach" {
  count = length(var.instance)
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = element(var.instance, count.index)
}