#!/bin/bash
echo "start-script"
s3fs $S3_BUCKET_NAME $S3_MOUNT_DIRECTORY -o url=https://nyc3.digitaloceanspaces.com -o passwd_file=/root/.passwd-s3fs