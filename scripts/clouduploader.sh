#!/bin/bash

az account show &> /dev/null

if [ $? -ne 0 ]; then
  echo "Please log in to Azure using 'az login' before running this script"
  exit 1
fi