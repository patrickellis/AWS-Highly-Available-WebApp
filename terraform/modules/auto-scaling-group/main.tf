
resource "aws_autoscaling_group" "auto-scaling-group" {
  name                      = var.autoscaling_group_name
  max_size                  = var.max_cap
  min_size                  = var.min_cap
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = var.target_cap
  force_delete              = true

  launch_template {
    id = var.launch_template_id
  }
  vpc_zone_identifier = var.vpc_subnets
  target_group_arns   = var.target_group_arns
}
