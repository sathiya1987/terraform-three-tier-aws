resource "aws_lb" "alb" {
  name                          = "${name_prefix}-alb"
  internal                      = var.internal 
  load_balancer_type            = "application"
  security_groups               = var.internal != "internal" ? [aws_security_group.alb_https.id] : [aws_security_group.alb_http.id]
  subnets                       = var.subnets
  enable_deletion_protection    = true
  access_logs {
    bucket                      = var.s3_bucket
    prefix                      = "test-lb"
    enabled                     = true
  }

  tags = {
    Name                       = "ALb"
  }
}

#TG settings
resource "aws_lb_target_group" "frontend_tg" {
  name                         = "${name_prefix}-tg"
  port                         = 80
  protocol                     = "HTTP"
  vpc_id                       = var.vpc_id
  target_type                  = var.target_type 
}

resource "aws_lb_target_group_attachment" "alb_attachment" {
  target_group_arn             = aws_lb_target_group.frontend_tg.arn
  target_id                    = var.target_id.id
  port                         = 80
}

resource "aws_lb_listener" "https_listerner" {
  count                        = var.https_enabled ? 1 : 0
  load_balancer_arn            = aws_lb.alb.arn
  port                         = "443"
  protocol                     = "HTTPS"
  ssl_policy                   = "ELBSecurityPolicy-2016-08"
  certificate_arn              = var.certificate_arn

  default_action {
    type                       = "forward"
    target_group_arn           = aws_lb_target_group.frontend_tg.arn
  }
}

resource "aws_lb_listener" "http_listerner" {
    count                      = var.https_enabled == false ? 1 : 0
  load_balancer_arn            = aws_lb.alb.arn
  port                         = "80"
  protocol                     = "HTTP"
  default_action {
    type                       = "forward"
    target_group_arn           = aws_lb_target_group.frontend_tg.arn
  }
}

resource "aws_security_group" "alb_https" {
  name                         = "${name_prefix}-alb_https"
  description                  = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id                       = var.vpc_id

  ingress {
    from_port                  = 443
    to_port                    = 443
    protocol                   = "tcp"
    cidr_blocks                = ["0.0.0.0/0"]
  }

  egress {
    from_port                  = 0
    to_port                    = 0
    protocol                   = "-1"
    cidr_blocks                = ["0.0.0.0/0"]
  }

  tags = {
    Name                       = "ALB-SG"
  }
}

resource "aws_security_group" "alb_http" {
  name                         = "${name_prefix}-alb_https"
  description                  = "Allow HTTP traffic to instances through Elastic Load Balancer"
  vpc_id                       = var.vpc_id

  ingress {
    from_port                  = 80
    to_port                    = 80
    protocol                   = "tcp"
    cidr_blocks                = ["subnet range"]
  }

  egress {
    from_port                  = 0
    to_port                    = 0
    protocol                   = "-1"
    cidr_blocks                = ["0.0.0.0/0"]
  }

  tags = {
    Name                       = "ALB-SG"
  }
}

output "alb_object" {
  value = aws_lb.alb
}