#!/bin/bash
NAMES=("mongodb" "web")
INSTANCE_TYPE=" "
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP_ID=sg-0c21f4afbf4430ceb
DOMAIN_NAME=joindevops.cloud
for i in "${NAMES[@]}"
do   
    if [[$i == "mongodb" || $i == "web"]] 
    then
        INSTANCE_TYPE="t3.micro"
    else
        INSTANCE_TYPE="t2.micro"
    fi 
    echo "creating $i instance"
    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID  --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress')
    echo "created $i instance: $IP_ADDRESS"
    done