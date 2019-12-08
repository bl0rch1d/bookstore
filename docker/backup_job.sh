#!/bin/bash

set -e

echo "DBA container has been started"

echo "Get aws credentials..."

export AWS_ACCESS_KEY_ID=$(curl http://$METADATA_ENDPOINT_IP$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI | python -c "import sys, json; print json.load(sys.stdin)['AccessKeyId']")

export AWS_SECRET_ACCESS_KEY=$(curl http://$METADATA_ENDPOINT_IP$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI | python -c "import sys, json; print json.load(sys.stdin)['SecretAccessKey']")

export AWS_SESSION_TOKEN=$(curl http://$METADATA_ENDPOINT_IP$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI | python -c "import sys, json; print json.load(sys.stdin)['Token']")

echo "Credentials received"

echo "Set cron execution environment"
env > /root/cronenv

echo "Set background job and start cron"

echo "$SCHEDULE /var/www/bookstore/docker/backup.sh >> /var/log/cron.log 2>&1
# Extra line for valid cron" > scheduler


# echo "$SCHEDULE . $HOME/.profile; /var/www/bookstore/docker/backup.sh $PG_HOST \
#                                                       $PG_USERNAME \
#                                                       $POSTGRES_DATABASE \
#                                                       $S3_BUCKET \
#                                                       $S3_FOLDER \
#                                                       $AWS_ACCESS_KEY_ID \
#                                                       $AWS_SECRET_ACCESS_KEY \
#                                                       $AWS_SESSION_TOKEN \
#                                                       $S3_REGION >> /var/log/cron.log 2>&1
# # Extra line for valid cron" > scheduler

crontab scheduler

cron -f
