# AWS-Auto-Scaling-Group
> Module to provision an autoscaling group
_Inputs_:
- autoscaling_group_name: Name for the group in AWS
- launch_template_id: ID for the template to use to provision EC2 instances
- vpc_id: id of VPC to provision EC2's inside
- vpc_subnets: subnets for availability zones / regions to target
- min_cap: minimum number of EC2 instances
- target_cap: desired number of EC2 instances
- max_cap: maximum number of EC2 instances
