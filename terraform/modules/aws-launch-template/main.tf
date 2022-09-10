# Todo:
# Create an SSH key_pair and insert it into the launch template
# update availability zone from eu-west-1a
# Add variables used below

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from TCP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "launch_template" {
  name = var.name

  block_device_mappings {
    device_name = var.device_name

    ebs {
      volume_size           = var.volume_size
      volume_type           = "gp2"
      delete_on_termination = true

    }
  }

  key_name = "ec2-user"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  image_id = var.image_id

  instance_type = var.instance_type

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.allow_http.id]
  }

  update_default_version = true

  # vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data = filebase64("${path.module}/user_data.sh")
}

variable "vpc_id" {
  type        = string
  description = "Default VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for default VPC"
}

output "template_id" {
  value = aws_launch_template.launch_template.id
}
