variable "name_prefix" {
  type                          = string
  default                       = ""
  description                   = "(Required) Creates a unique name beginning with the specified prefix."
}

variable "internal" {
  type                          = string
  default                       = ""
  description                   = "If true, the LB will be internal"
}

variable "subnets" {
  type                          = list
  description                   = "(Required) subnets to use ALB"
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

variable "target_id" {
 description = "autoscale object"
}

variable "certificate_arn" {
  type                          = string
}

variable "https_enable" {
  type                          = bool
}


variable "s3_bucket" {
  type                          = string
}