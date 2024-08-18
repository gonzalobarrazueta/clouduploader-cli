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

# Ensures a file path is provided
FILE_PATH=$1

if [ -z "$FILE_PATH"]; then
  echo "Error: No file path provided. Please specify a file to upload."
  echo "Usage: $0 <file_path>"
  exit 1
fi
