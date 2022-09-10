
resource "aws_security_group" "allow_http_https" {
  name        = "allow_http_https"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from TCP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from TCP"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "front_end" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
}

resource "aws_lb" "front_end" {
  name               = var.load_balancer_name
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_https.id]
  subnets            = var.vpc_subnets
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_listener" "front_end_https" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "443"
  protocol          = "HTTPS"
  
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  certificate_arn   = "arn:aws:acm:eu-west-1:605871098869:certificate/0c28da66-e5d6-4ed7-be3b-db2524439b11"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

