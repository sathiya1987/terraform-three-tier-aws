#RDS variables
variable "multi_az" {
  type                          = bool
  default                       = true
  description                   = "(Optional) Specifies if the RDS instance is multi-AZ"
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
variable "name" {
  type                          = string
  default                       = ""
  description                   = "(Required) The instance name of the RDS instance"
}
variable "username" {
  type                          = string
  default                       = ""
  description                   = "(Required) Username for the master DB user"
}

variable "password" {
  type                          = string
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


 
 