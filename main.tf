module "webserver"{
  source                                         = "./ec2_autoscale"
  name_prefix                                    = var.name_prefix
  image_id                                       = var.image_id
  instance_type                                  = var.instance_type
  key_name                                       = var.keykey_name 
  security_groups                                = aws_security_group.web-sg.id
  device_name                                    = var.device_name
  volume_type                                    = var.volume_type 
  volume_size                                    = var.volume_size
  delete_on_termination                          = var.delete_on_termination 
  encrypted                                      = var.encrypted
  enable_monitoring                              = var.enable_monitoring
  max_size                                       = var.max_size
  min_size                                       = var.min_size
  health_check_type                              = var.health_check_type
  target_group_arns                              = module.alb_internal.alb_object
  desired_capacity                               = var.desired_capacity
  subnets                                        = var.subnets
}

module "appserver"{
  source                                         = "./ec2_autoscale"
  name_prefix                                    = var.name_prefix
  image_id                                       = var.image_id
  instance_type                                  = var.instance_type
  security_groups                                = aws_security_group.app-sg.id
  key_name                                       = var.keykey_name 
  device_name                                    = var.device_name
  volume_type                                    = var.volume_type 
  volume_size                                    = var.volume_size
  delete_on_termination                          = var.delete_on_termination 
  encrypted                                      = var.encrypted
  enable_monitoring                              = var.enable_monitoring
  max_size                                       = var.max_size
  min_size                                       = var.min_size
  health_check_type                              = var.health_check_type
  target_group_arns                              = module.alb_external.alb_object
  desired_capacity                               = var.desired_capacity
  subnets                                        = var.subnets
}

module "databaseserver"{
  source                                         = "./rds"
  allocated_storage                              = var.allocated_storage
  multi_az                                       = var.multi_az
  engine                                         = var.engine
  engine_version                                 = var.engine_version
  port                                           = var.port
  instance_class                                 = var.instance_class
  name                                           = var.name_prefix
  username                                       = local.rds_username
  password                                       = local.rds_password
  parameter_group_name                           = var.parameter_group_name
  skip_final_snapshot                            = var.skip_final_snapshot
  auto_minor_version_upgrade                     = var.auto_minor_version_upgrade
  kms_key_id                                     = var.kms_key_id 
}


module "alb_internal"{
  source                                         = "./alb"
  internal                                       = var.internal
  subnets                                        = var.subnets
  bucket                                         = var.s3_bucket
  vpc_id                                         = var.vpc_id
  target_type                                    = var.target_type 
  certificate_arn                                = https_enable == false ? var.certificate_arn : ""
  target_id                                      = module.appserver.aws_autoscaling_group_object
  https_enable                                   = false
}

module "alb_external"{
  source                                         = "./alb"
  internal                                       = var.internal
  subnets                                        = var.subnets
  bucket                                         = var.s3_bucket
  vpc_id                                         = var.vpc_id
  target_type                                    = var.target_type 
  certificate_arn                                = var.certificate_arn
  target_id                                      = module.webserver.aws_autoscaling_group_object
  https_enable                                   = true
}


# Create Web Security Group
resource "aws_security_group" "web-sg" {
  name        = "${name_prefix}-Web-SG"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["subnet range"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-SG"
  }
}

# Create Application Security Group
resource "aws_security_group" "app-sg" {
  name              = "${name_prefix}-app-SG"
  description       = "Allow inbound traffic from ALB"
  vpc_id            = var.vpc_id

  ingress {
    description     = "Allow traffic from web layer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                         = "app-SG"
  }
}