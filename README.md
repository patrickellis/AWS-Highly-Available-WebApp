# AWS Highly Available Web Service
> Repository to hold files for provisioning and configuring a highly available web application on AWS

Visit the website [here](https://www.patrickellis.dev)

## Architecture
At a high level, the provisioned resources are:
- EC2 Launch Template
    - Ubuntu 20.04
    - Apache Web Server
- Security Groups
    - EC2 (HTTP:80, SSH:20)
    - Load Balancer (HTTP:80, HTTPS:443)
- EC2 Auto-Scaling Group (Across three availability zones: eu-west-1a, eu-west-1b, eu-west-1c)
    - Auto-Scaling Policy (CPU Util 50%)
- Application Load Balancer
<p align="center">
    <img src="https://github.com/patrickellis/AWS-Highly-Available-WebApp/blob/main/images/Architecture-diagram.png" style="width:700px; height:500px; padding-top:100px;"/>
</p>

## Terraform
Terraform has been run with pre-commit hooks (see [pre-commit](https://pre-commit.com/))
Dependencies:
- pre-commit
    - [tflint](https://github.com/terraform-linters/tflint): A Pluggable Terraform Linter
    - [tfsec](https://aquasecurity.github.io/tfsec/): A static analysis security scanner
    - [checkov](https://github.com/bridgecrewio/checkov): A static code analysis tool for infrastructure-as-code

## Ansible 
- Used to create a test launch template and subsequently deploy EC2 with public IPs for configuration testing
- If more complex EC2 configuration was required, I would have used ansible to bootstrap a ubuntu AMI 

## Known Points for Improvement:
- Automate DNS resolution for domain name
- Manage Certificate for domain in terraform
- ~display a webapp instead of Apache2 test page -> via modification to userdata.sh in EC2 launch template~
- ~SED a .html file in the webapp to include the hostname and IP so we can validate Load balancing~
- If availability is absolutely critical, we could add a "warm pool" of VMs to the auto-scaling group for failover scenarios

## Further Considerations: 
- Monitoring and Maintainability:
    - CloudWatch monitoring enabled for EC2s
    - Group metrics collection enabled for AutoScaling Group
- Deploying to a Production environment that has VMs already running? 
    - use the target group as a data source
    - add a new auto scaling group to the target group
    - if existing VMs are already inside an auto scaling group, use the group as a data source instead and modify the params
- Capacity and Growth:
    - Auto scaling group:
        - Dynamic scaling policy (simple scaling) +1 cap units per 5 minutes, can be adjusted
        - Triggered at 50% avg. CPU utilization
