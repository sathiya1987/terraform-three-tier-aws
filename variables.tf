variable "region" {
  type                          = string
  default                       = "east-us-1"
  description                   = "Name of the aws region"
}


#Autoscale Lanuch Configuration settings 
variable "name_prefix" {
  type                          = string
  default                       = "test-ec2_lanuch"
  description                   = "(Required) Creates a unique name beginning with the specified prefix."
}

variable "image_id" {
  type                          = string
  default                       = ""
  description                   = "(Required) The EC2 image ID to launch"
}

variable "instance_type" {
  type                          = string
  default                       = "t2.micro"
  description                   = "(Required) The size of instance to launch"
}

variable "key_name" {
  type                          = string
  default                       = ""
  description                   = "(Optional) The key name that should be used for the instance"
}

variable "enable_monitoring" {
  type                          = bool
  default                       = true
  description                   = "(Optional) Enables/disables detailed monitoring"
}

#EBS BlockDevice settings
variable "device_name" {
  type                          = string
  default                       = ""
  description                   = "(Required) The name of the device to mount"
}

 variable "volume_type" {
  type                          = string
  default                       = ""
  description                   = "The type of volume"
}

variable "volume_size" {
  type                          = string
  default                       = ""
  description                   = "(Optional) The size of the volume in gigabytes."
}

variable "delete_on_termination" {
  type                          = bool
  default                       = true
  description                   = "(Optional) Whether the volume should be destroyed on instance termination "
}

variable "encrypted" {
  type                          = bool
  default                       = true
  description                   = "(Optional) Whether the volume should be encrypted or not. Do not use this option if you are using snapshot_id as the encrypted flag will be determined by the snapshot."
}

#Autoscale Group settings

variable "max_size" {
  type                          = number
  description                   = "(Required) The maximum size of the Auto Scaling Group"
}
variable "min_size" {
  type                          = number
  description                   = "(Required) The minimum size of the Auto Scaling Group"
}
variable "health_check_type" {
  type                          = string
  default                       = "ELB"
  description                   = "(Optional) EC2 or ELB"
}
variable "desired_capacity" {
  type                          = number
  description                   = "(Optional) The number of Amazon EC2 instances that should be running in the group"
} 
 variable "subnets" {
  type                          = list
  description                   = "(Required) The minimum size of the Auto Scaling Group"
} 

 #RDS variables
variable "multi_az" {
  type                          = bool
  default                       = "true"
  description                   = " (Optional) Specifies if the RDS instance is multi-AZ"
}

variable "engine" {
  type                          = string
  default                       = ""
  description                   = "The database engine to use"
}

variable "allocated_storage" {
  type                          = number
  description                   = "The allocated storage in gibibytes"
}

variable "engine_version" {
  type                          = string
  default                       = ""
  description                   = "(Optional) The engine version to use"
}

variable "port" {
  type                          = number
  description                   = "(Optional) The port on which the DB accepts connections"
}

variable "instance_class" {
  type                          = string
  default                       = ""
  description                   = "(Required) The instance type of the RDS instance"
}

variable "parameter_group_name" {
  type                          = string
  default                       = ""
  description                   = "(Optional) Name of the DB parameter group to associate"
}

variable "skip_final_snapshot" {
  type                          = bool
  default                       = true
  description                   = "(Optional) Name of the DB parameter group to associate"
}


variable "auto_minor_version_upgrade" {
  type                          = bool
  default                       = true
  description                   = "(Optional) Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
}
variable "kms_key_id" {
  type                          = string
  default                       = ""
  description                   = "((Optional) The ARN for the KMS encryption key"
}

#ALB
variable "internal" {
  type                          = string
  default                       = ""
  description                   = "If true, the LB will be internal"
}

variable "vpc_id" {
  type                          = string
  default                       = ""
  description                   = "(Required) vpc_id for ALB"
}

variable "target_type" {
  type                          = string
  default                       = "instance"
}

variable "certificate_arn" {
  type                          = string
}

variable "s3_bucket" {
  type                          = string
}
 




















