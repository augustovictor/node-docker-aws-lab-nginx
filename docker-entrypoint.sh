#!/usr/bin/env bash

# Exit the script as soon as something exits with a non 0 exit code
set -e

# The backend name should be the name of the docker image that is linked to nginx
# Hardcoded configs in nginx.conf will be replaced with these values in runtime
PLACEHOLDER_BACKEND_NAME="node-app-aws"
PLACEHOLDER_BACKEND_PORT="3000"

PLACEHOLDER_VHOST="$(curl http://169.254.169.254/latest/meta-data/public-hostname)"

DEFAULT_CONFIG_PATH="etc/nginx/conf.d/default.conf"

# Replace all instances of placeholders with values above
sed -i "s/PLACEHOLDER_VHOST/${PLACEHOLDER_VHOST}/g" "${DEFAULT_CONFIG_PATH}"
sed -i "s/PLACEHOLDER_BACKEND_NAME/${PLACEHOLDER_BACKEND_NAME}/g" "${DEFAULT_CONFIG_PATH}"
sed -i "s/PLACEHOLDER_BACKEND_PORT/${PLACEHOLDER_BACKEND_PORT}/g" "${DEFAULT_CONFIG_PATH}"

# Execute the CMD directive from Dockerfile and pass in all of its arguments
exec "$@"