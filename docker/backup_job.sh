#!/bin/bash

retreive_aws_credentials() {
    export CONTAINER_CREDENTIALS=$(curl -s http://$METADATA_ENDPOINT_IP$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI)
    
    export AWS_ACCESS_KEY_ID=$(python -c "import sys, os, json; print json.loads(os.environ['CONTAINER_CREDENTIALS'])['AccessKeyId']")
    
    export AWS_SECRET_ACCESS_KEY=$(python -c "import sys, os, json; print json.loads(os.environ['CONTAINER_CREDENTIALS'])['SecretAccessKey']")
    
    export AWS_SESSION_TOKEN=$(python -c "import sys, os, json; print json.loads(os.environ['CONTAINER_CREDENTIALS'])['Token']")

    unset CONTAINER_CREDENTIALS

    echo "[+] Credentials received"
}

prepare_execution_context() {
    echo "PG_HOST=$PG_HOST
    PG_PORT=$PG_PORT
    PG_USERNAME=$PG_USERNAME
    POSTGRES_DATABASE=$POSTGRES_DATABASE
    S3_BUCKET=$S3_BUCKET
    S3_FOLDER=$S3_FOLDER
    S3_REGION=$S3_REGION
    PGPASSWORD=$PGPASSWORD
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN" >> /root/cron_ctx

    echo "[+] Cron execution environment prepared"
}

prepare_cron_job() {
    echo "$SCHEDULE /var/www/bookstore/docker/backup.sh >> /var/log/cron.log 2>&1
    # Extra line for valid cron" > scheduler

    crontab scheduler

    echo "[+] Cron job prepared"
}

preparations_done_msg() {
    echo "[*]-------------------------------------------[*]"
    echo "[*]-------- All preparations done! -----------[*]"
    echo "[*]-------------------------------------------[*]"
}

fire_cron() {
    echo "[***] Firing cron in foreground mode [***]"

    cron -f
}

start() {
    echo "DBA container has been started"

    retreive_aws_credentials
    prepare_execution_context
    prepare_cron_job
    preparations_done_msg
    fire_cron
}

set -e

start
