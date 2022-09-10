# Module application_load_balancer
> Module to provision an ALB in AWS

_Inputs_:
- vpc_id: id of VPC to use
- target_group_name: name for the target group to be created
- target_group_port: port for the target group to receive traffic on
- target_group_protocol: communication protocol for the target group, e.g. HTTP
- load_balancer_name: name for the load balancer
- vpc_subnets: subnets for the availability zones to target
