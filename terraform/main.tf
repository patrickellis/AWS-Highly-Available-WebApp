terraform {
  required_providers {
    aws = {
      version = "4.26.0"
      source  = "hashicorp/aws"
    }
  }
}

module "launch_template" {
  source        = "./modules/aws-launch-template"
  name          = "apache_template"
  instance_type = "t2.micro"
  image_id      = "ami-0d75513e7706cf2d9"
  vpc_id        = data.aws_vpc.main.id
  vpc_cidr      = data.aws_vpc.main.cidr_block
}

module "auto_scaling_group" {
  source                 = "./modules/auto-scaling-group"
  autoscaling_group_name = "autoscaling_group_demo"
  launch_template_id     = module.launch_template.template_id
  target_group_arns      = module.application_load_balancer.arns
  vpc_id                 = data.aws_vpc.main.id
  vpc_subnets            = local.vpc_subnets
}

module "application_load_balancer" {
  source                = "./modules/application-load-balancer"
  vpc_id                = data.aws_vpc.main.id
  target_group_name     = "lb-target-group"
  target_group_port     = 80
  target_group_protocol = "HTTP"
  load_balancer_name    = "app-lb"
  vpc_subnets           = local.vpc_subnets
}


resource "aws_vpc" "main" {
  cidr_block       = "172.31.0.0/16"
  instance_tenancy = "default"
}

data "aws_vpc" "main" {
  id = "vpc-0c87c1891dd1c254a"
}

resource "aws_subnet" "euwest-1a" {
  vpc_id               = data.aws_vpc.main.id
  cidr_block           = "172.31.48.0/20"
  availability_zone_id = "euw1-az1"
}


resource "aws_subnet" "euwest-1b" {
  vpc_id               = data.aws_vpc.main.id
  cidr_block           = "172.31.64.0/20"
  availability_zone_id = "euw1-az2"
}


resource "aws_subnet" "euwest-1c" {
  vpc_id               = data.aws_vpc.main.id
  cidr_block           = "172.31.80.0/20"
  availability_zone_id = "euw1-az3"
}

locals {
  vpc_subnets = [aws_subnet.euwest-1a.id, aws_subnet.euwest-1b.id, aws_subnet.euwest-1c.id]
}
