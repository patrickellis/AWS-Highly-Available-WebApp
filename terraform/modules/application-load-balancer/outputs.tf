output "arns" {
  value = toset([aws_lb_target_group.front_end.arn])
}
