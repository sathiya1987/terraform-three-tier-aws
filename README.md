 ## terraform-three-tier-aws
Terraform Module for Azure SQL with Private Endpoint.

# Prerequisites
This module has a few dependencies:

# Terraform 0.13

# Export Your AWS account crdentials as environment variables
 export access_key
 export secret_key

## Expected Use
This module is written to deploy ec2 instances with autoscale ,rds,alb  on aws account. 

This module is ideal for :
* Two avaibility zones 

## Resources getting deployed
* EC2 instances.
* RDS with multi-az
* Internal and External ALB

## Deployment mechanism
* Manual 

# Terraform commands to execute 
    1.terraform init
    2.terraform plan  -var-file terraform.tfvars 
    3.terraform apply -var-file terraform.tfvars 
    4.terraform destroy -var-file terraform.tfvars 

 # Sample inputs
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

## Module TODO's
* Gitops Model
* Sentinel or test case /terratest 


## Change Log
* 1.0.0 - nov 17, 2021 - Initial Release
