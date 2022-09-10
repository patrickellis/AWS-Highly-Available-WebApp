variable "vpc_subnets" {
  type        = list(string)
  description = "List of subnet ids for availability zones used by this infrastructure"
}

variable "vpc_id" {
  type        = string
  description = "Default VPC"
}

variable "target_group_name" {
  type        = string
  description = "name of target group"
}

variable "target_group_protocol" {
  type        = string
  description = "Protocol to use for target group"
}

variable "target_group_port" {
  type        = number
  description = "Port to use for target group forwarding"
}

variable "load_balancer_name" {
  type        = string
  description = "Name to use for the application load balancer"
}
