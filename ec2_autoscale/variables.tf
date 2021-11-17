
#Autoscale Lanuch Configuration settings 
variable "name_prefix" {
  type                          = string
  default                       = ""
  description                   = "(Required) Creates a unique name beginning with the specified prefix."
}

variable "image_id" {
  type                          = string
  default                       = ""
  description                   = "(Required) The EC2 image ID to launch"
}

variable "security_groups" {
  type                          = string
  default                       = ""
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
  description                   = "(Optional) The type of volume"
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
 variable "vpc_zone_identifier" {
  type                          = list
  description                   = "(Required) The minimum size of the Auto Scaling Group"
} 
 variable "target_group_arns" {
  description                   = "(Required) ALB target ARN"
} 
 