# AWS Highly Available Web Service
> Repository to hold files for provisioning and configuring a highly available web application on AWS

## Architecture
At a high level, the provisioned resources are:
- EC2 Launch Template
- Security Groups
    - EC2 (HTTP:80, SSH:20)
    - Load Balancer (HTTP:80, HTTPS:443)
- EC2 Auto-Scaling Group (Across three availability zones: eu-west-1a, eu-west-1b, eu-west-1c)
- Application Load Balancer

## Terraform
Terraform has been run with pre-commit hooks (see [pre-commit](https://pre-commit.com/))
Dependencies:
- pre-commit
    - [tflint](https://github.com/terraform-linters/tflint): A Pluggable Terraform Linter
    - [tfsec](https://aquasecurity.github.io/tfsec/): A static analysis security scanner
    - [checkov](https://github.com/bridgecrewio/checkov): A static code analysis tool for infrastructure-as-code
