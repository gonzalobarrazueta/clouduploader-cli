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

if [ -z "$FILE_PATH" ]; then
  echo "Error: Please specify a file to upload."
  echo "Usage: $0 <file_path>"
  exit 1
fi

# Ensures the file exists
if [ ! -f "$FILE_PATH" ]; then
  echo "Error: File not found. Please provide a valid file path."
  exit 1
fi

# Extracts the file name without the extension or path
file_name=$(echo "$FILE_PATH" | grep -o '[^/]*$')

# Checks if a blob with the same name already exists in the container
blob_exists=$(az storage blob exists \
       --account-name "$AZURE_STORAGE_ACCOUNT" \
       --container-name "$CONTAINER_NAME" \
       --name "$file_name" \
       --auth-mode login \
       --query exists)

if [ "$blob_exists" = "true" ]; then
  echo "File already exists in container. Please rename it or use a new file."
  exit 1
fi

# Upload file to Azure Blob Storage
az storage blob upload \
	--account-name "$AZURE_STORAGE_ACCOUNT" \
	--container-name "$CONTAINER_NAME" \
	--file "$FILE_PATH" \
	--auth-mode login

if [ $? -eq 0 ]; then
  echo "File uploaded successfully"
else
  echo "Error: File upload failed. Please try again."
  exit 1
fi
