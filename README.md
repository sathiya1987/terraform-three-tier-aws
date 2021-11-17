Prerequisites
This module has a few dependencies:

Terraform 0.13

Export Your AWS account crdentials
 export access_key
 export secret_key

Git clone or Fork 


Terraform commands to execute 
    1.terraform init
    2.terraform plan -var-file terraform.tfvars 
    3.terraform apply -var-file terraform.tfvars 
    4.terraform destroy -var-file terraform.tfvars 

Sample inputs
terraform.tfvars 
region                         = "eastus-1"
 name_prefix                    = "three-tier"
 image_id                       = ""
 instance_type                  = ""
 key_name                       = ""
 enable_monitoring              = false
 device_name                    = ""
 volume_type                    = ""
 volume_size                    = ""
 delete_on_termination          = false
 encrypted                      = false
 max_size                       = 4
 min_size                       = 2
 health_check_type              = ""
 desired_capacity               = ""
 subnets                        = ["",""]
 multi_az                       = true
 engine                         = ""
 allocated_storage              = 10
 engine_version                 = ""
 port                           = 3306
 parameter_group_name           = ""
 skip_final_snapshot            = false
 auto_minor_version_upgrade     = false
 kms_key_id                     = ""
 internal                       = "internal"
 vpc_id                         = ""
 target_type                    = ""
 s3_bucket                      = ""