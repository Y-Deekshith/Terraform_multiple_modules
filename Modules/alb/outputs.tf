output "albarn" {
  value = aws_lb.myalb.arn
}
output "tgarn" {
  value = aws_lb_target_group.alb_tg.arn
}
output "alb_tgid" {
  value = aws_lb_target_group.alb_tg.id
}
output "alb_id" {
  value = aws_lb.myalb.id
}
output "alb_dns" {
  value = aws_lb.myalb.dns_name
}
output "alb_zone" {
  value = aws_lb.myalb.zone_id
}