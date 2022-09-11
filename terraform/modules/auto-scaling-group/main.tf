resource "aws_autoscaling_policy" "auto-scaling-policy" {
    name = "policy-demo"
    autoscaling_group_name = aws_autoscaling_group.auto-scaling-group.name
    cooldown = 300
    enabled = true
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
}

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
    version = "$Latest"
  }

  enabled_metrics = ["GroupInServiceInstances", "GroupPendingInstances", "GroupTotalInstances", "GroupTotalCapacity"]
  vpc_zone_identifier = var.vpc_subnets
  target_group_arns   = var.target_group_arns
}
