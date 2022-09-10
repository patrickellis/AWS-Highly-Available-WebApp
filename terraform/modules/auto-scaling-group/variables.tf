variable "vpc_subnets" {
  type        = list(string)
  description = "List of subnet ids for availability zones used by this infrastructure"
}

# Output from launch instance module (we could move this into main.tf in top level)
variable "vpc_id" {
  type        = string
  description = "VPC to use for subnets (Required)"
}

variable "launch_template_id" {
  type        = string
  description = "ID of launch template to deploy (Required)"
}

variable "target_group_arns" {
  type        = list(string)
  description = "List of target group ARNS to use"
}

variable "autoscaling_group_name" {
  type        = string
  description = "Name of autoscaling group (Required)"
}

variable "min_cap" {
  type        = number
  description = "Minimum number of EC2 instances to provision"
  default     = 1
}

variable "target_cap" {
  type        = number
  description = "Desired number of EC2 instances to provision"
  default     = 3
}

variable "max_cap" {
  type        = number
  description = "Maximum number of EC2 instances to provision"
  default     = 5
}
