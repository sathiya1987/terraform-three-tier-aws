# Autoscaling Lanuch Configuration
resource "aws_launch_configuration" "autoscale_lanuch_config" {
  name_prefix                = "${var.name_prefix}-ec2_lc"
  image_id                   = var.image_id
  instance_type              = var.instance_type
  key_name                   = var.keykey_name 
  security_groups            = var.security_groups
  ebs_block_device{
      device_name            = var.device_name
      volume_type            = var.volume_type 
      volume_size            = var.volume_size
      delete_on_termination  = var.delete_on_termination 
      encrypted              = var.encrypted

  }
  enable_monitoring          = var.enable_monitoring
}

# Autoscale Group Configuration

resource "aws_autoscaling_group" "server" {
  name                        = "${var.name_prefix}-asg"
  max_size                    = var.max_size
  min_size                    = var.min_size
  health_check_grace_period   = 300
  health_check_type           = var.health_check_type
  desired_capacity            = var.desired_capacity
  launch_configuration        = aws_launch_configuration.autoscale_lanuch_config.name
  vpc_zone_identifier         = var.subnets
  target_group_arns           = var.target_group_arns.arn
  depends_on                  = [aws_launch_configuration.autoscale_lanuch_config]
}

#Autoscale Policies 
resource "aws_autoscaling_policy" "web_policy_up" {
  name = "${name_prefix}-web_policy_up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.server.name
}

#Cloudwatch metrics
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name = "${name_prefix}-web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.server.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.web_policy_up.arn ]
}

resource "aws_autoscaling_policy" "web_policy_down" {
  name = "${name_prefix}-web_policy_down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.server.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name = "${name_prefix}-web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.server.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.web_policy_down.arn ]
}

output "aws_autoscaling_group_object" {
  value = aws_autoscaling_group.server
}