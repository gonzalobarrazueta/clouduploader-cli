#!/bin/bash

ENV_FILE="../config/.env"

if [ -f "$ENV_FILE" ]; then
  # Filters out lines that are comments and creates the environment variables
  export $(grep -v '^#' "$ENV_FILE" | xargs)
fi

# Ensures the user is logged in to Azure
az account show &> /dev/null

if [ $? -ne 0 ]; then
  echo "Please log in to Azure using 'az login' before running this script"
  exit 1
fi