#!/bin/bash

#Validate templates START

./tests/validate-templates.sh

#Validate templates END

while getopts ":b:" opt; do
  case $opt in
    b) AWS_S3_BUCKET_NAME="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

#AWS S3 Push configs to bucket START

baseUrl="https://$AWS_S3_BUCKET_NAME.s3.$region.amazonaws.com/"

aws s3 mb "s3://$AWS_S3_BUCKET_NAME"

vpc_url="s3://$AWS_S3_BUCKET_NAME/infrastructure/vpc.yaml"
aws s3 cp "./infrastructure/vpc.yaml" "$vpc_url"
aws s3api put-object-acl --bucket "$AWS_S3_BUCKET_NAME" --key "infrastructure/vpc.yaml" --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers

security_groups_url="s3://$AWS_S3_BUCKET_NAME/infrastructure/security-groups.yaml"
aws s3 cp "./infrastructure/security-groups.yaml" "$security_groups_url"
aws s3api put-object-acl --bucket "$AWS_S3_BUCKET_NAME" --key "infrastructure/security-groups.yaml" --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers

load_balancers_url="s3://$AWS_S3_BUCKET_NAME/infrastructure/load-balancers.yaml"
aws s3 cp "./infrastructure/load-balancers.yaml" "$load_balancers_url"
aws s3api put-object-acl --bucket "$AWS_S3_BUCKET_NAME" --key "infrastructure/load-balancers.yaml" --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers

ecs_cluster_url="s3://$AWS_S3_BUCKET_NAME/infrastructure/ecs-cluster.yaml"
aws s3 cp "./infrastructure/ecs-cluster.yaml" "$ecs_cluster_url"
aws s3api put-object-acl --bucket "$AWS_S3_BUCKET_NAME" --key "infrastructure/ecs-cluster.yaml" --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers

lifecyclehook_url="s3://$AWS_S3_BUCKET_NAME/infrastructure/lifecyclehook.yaml"
aws s3 cp "./infrastructure/lifecyclehook.yaml" "$lifecyclehook_url"
aws s3api put-object-acl --bucket "$AWS_S3_BUCKET_NAME" --key "infrastructure/lifecyclehook.yaml" --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers

frontend_service_url="s3://$AWS_S3_BUCKET_NAME/services/frontend.yaml"
aws s3 cp "./services/frontend.yaml" "$frontend_service_url"
aws s3api put-object-acl --bucket "$AWS_S3_BUCKET_NAME" --key "services/frontend.yaml" --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers

backend_service_url="s3://$AWS_S3_BUCKET_NAME/services/backend.yaml"
aws s3 cp "./services/backend.yaml" "$backend_service_url"
aws s3api put-object-acl --bucket "$AWS_S3_BUCKET_NAME" --key "services/backend.yaml" --grant-read uri=http://acs.amazonaws.com/groups/global/AllUsers
