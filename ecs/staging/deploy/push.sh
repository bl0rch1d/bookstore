#!/bin/sh
set -e

# if [ ! -f ../../config/master.key ]; then
#   if [ -z "$RAILS_STAGING_KEY" ]; then
#     echo "No rails master key"
#     exit 1
#   fi

#   echo "$RAILS_STAGING_KEY" > ../../config/credentials/staging.key
# fi

export TAG=$(git log -1 --format=%h)

# AWS Login
$(aws ecr get-login --no-include-email)

# Build images
docker-compose build app web

# Upload to ECR
docker-compose push app web

CLUSTER=bookstore
REGION=us-east-2
SERVICE=bookstore-staging

# Deploy
ecs-cli configure \
  --cluster $CLUSTER \
  --region $REGION \
  --default-launch-type EC2 \
  -config-name $CLUSTER

ecs-cli compose \
  --project-name $SERVICE \
  --ecs-params ecs_params.yml \
  service up \
  --cluster-config $CLUSTER \
  --force-deployment \
  --timeout 2 \
  --deployment-max-percent 100 \
  --deployment-min-healthy-percent 0
