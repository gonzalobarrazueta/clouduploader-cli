# 🗂️ Cloud Uploader

## Pre-requisites
You need to have the **Azure CLI** installed in your computer. You can reference [this guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) for more information about installing in your operating system.

## Setup

These steps will help you create the storage resources needed to upload files to Azure.

1. Log into azure using the Azure CLI.
   ```
    az login
   ```
2. Create a resource group for your storage account.
   ```
    az group create --name <resource-group-name> --location <location>
   ```
3. Create a storage account.
   Make sure that the location that you specify in this command is the same as the one that you specified for your resource group.
   ```
   az storage account create --name <azure-storage-account-name> --resource-group <resource-group-name> --location <location> --sku Standard_RAGRS --kind StorageV2 --min-tls-version TLS1_2 --allow-blob-public-access false
   ```
4. Create a blob container where all your files will be uploaded.
   ```
   az storage container create --name <container-name> --account-name <azure-storage-account-name>
   ```

## How to run the script

1. Clone the repository.
2. Create a `config` folder at the same level as the `scripts` folder. Inside the `config`folder, add an `.env` file with the following variables:
   ```
   AZURE_STORAGE_ACCOUNT=<azure-storage-account-name>
   CONTAINER_NAME=<container-name>
   AZURE_STORAGE_CONNECTION_STRING=<connection-string>
    ```
3. If you decide to create the environment file anywhere else other than the `config/.env` path, then make sure that the `ENV_FILE` variable in `clouduploader.sh` (at line 3) is updated with the correct path.
4. Run the script with the following command:
   ```
   bash clouduploader.sh <file-path>
   ```
   Where `<file-path>` is the path to the file that you want to upload to Azure.

## 🎮 Demo