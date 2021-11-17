#!/usr/bin/env bash

function describe_instances (){
    local response

# it will iterate 
    for region in 'aws ec2 describe-regions --output text | cut -f3'
    do
        echo -e "\n Listing Instances in region:'$region'..."
        response=$(aws ec2 describe-instances \
        --query 'Reservations[*].Instances[*].{Instance:InstanceId,ImageID:ImageId,Platform:Platform}' \
        --output json\
        )
    done   
    echo "$response"

    if [[ -z "$response" ]]; then
            errecho "ERROR: I can't find the instance  in the current AWS account."
            return 1
    fi
}