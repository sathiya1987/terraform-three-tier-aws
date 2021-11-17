resource "aws_db_instance" "db" {
  allocated_storage             = var.allocated_storage
  multi_az                      = var.multi_az
  engine                        = var.engine
  engine_version                = var.engine_version
  port                          = var.port
  instance_class                = var.instance_class
  name                          = var.name
  username                      = var.username
  password                      = var.password
  parameter_group_name          = var.parameter_group_name
  skip_final_snapshot           = var.skip_final_snapshot
  auto_minor_version_upgrade    = var.auto_minor_version_upgrade
  kms_key_id                    = var.kms_key_id 
  vpc_security_group_ids        = aws_security_group.database-sg.id
  tags = {
    Name = "Database"
  }
}

# Create Database Security Group
resource "aws_security_group" "database-sg" {
  name        = "Database-SG"
  description = "Allow inbound traffic from application layer"
  vpc_id      = var.vpc_id
  ingress {
    description     = "Allow traffic from application layer"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["subnet range for app/webservers"]
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database-SG"
  }
}