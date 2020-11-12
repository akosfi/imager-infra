#!/bin/bash

region="eu-west-3"
output="json"

while getopts ":k:s:b:c:" opt; do
  case $opt in
    k) AWS_ACCESS_KEY="$OPTARG"
    ;;
    s) AWS_ACCESS_SECRET="$OPTARG"
    ;;
    b) AWS_S3_BUCKET_NAME="$OPTARG"
    ;;
    c) CLOUDFORMATION_STACK_NAME="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

printf "$AWS_ACCESS_KEY\n$AWS_ACCESS_SECRET\n$region\n$output\n" | aws configure

./build.sh -b "$AWS_S3_BUCKET_NAME"

aws cloudformation deploy \
    --template-file master.yaml \
    --stack-name $CLOUDFORMATION_STACK_NAME \
    --capabilities CAPABILITY_NAMED_IAM