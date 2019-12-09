#!/bin/bash

retreive_execution_context() {
    while read LINE; do export "$LINE"; done < /root/cron_ctx

    echo "[+] Execution context retrieved"
}

dump_db() {
    pg_dump -h $PG_HOST -p $PG_PORT -U $PG_USERNAME -d $POSTGRES_DATABASE | gzip > dump.sql.gz

    echo "[+] DB dumped"
}

push_to_sss() {
    cat dump.sql.gz | aws s3 cp - s3://$S3_BUCKET/$S3_FOLDER/"$POSTGRES_DATABASE"_$(date +"%Y-%m-%dT%H:%M:%SZ").sql.gz || exit 2

    echo "[+] Pushed to s3"
}

start() {
    echo "\n\n[***] Starting backup proccess. $(date +"%Y-%m-%dT%H:%M:%SZ") [***]"

    retreive_execution_context
    dump_db
    push_to_sss

    echo "[***] Succeeded! [***]"
}

set -e

start
