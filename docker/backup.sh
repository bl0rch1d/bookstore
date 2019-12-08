#!/bin/bash

set -e

echo 'Retreive execution environment'
while read LINE; do export "$LINE"; done < cronenv

echo "Start backup proccess..."

pg_dump -h $PG_HOST -p 5432 -U $PG_USERNAME -d $POSTGRES_DATABASE | gzip > dump.sql.gz

echo "Push to s3..."

cat dump.sql.gz | aws s3 cp - s3://$S3_BUCKET/$S3_FOLDER/$POSTGRES_DATABASE_$(date +"%Y-%m-%dT%H:%M:%SZ").sql.gz || exit 2

echo "Backup pushed successfully!"
