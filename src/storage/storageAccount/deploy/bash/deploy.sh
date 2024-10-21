#!/bin/bash

set -euo pipefail

# Variables
resourceGroup='storageRg'
location='westus3'
enviType="${1:-dev}"

# Function to create resource group
createResourceGroup() {
    echo "Creating resource group: $resourceGroup in location: $location"
    az group create --name "$resourceGroup" --location "$location"
}

# Function to deploy storage account
deployStorageAccount() {

    echo "Building bicep file"
    az bicep build -f ../deployStorage.bicep --outfile storageAccount.json

    if [ $? -ne 0 ]; then
        echo "Failed to build bicep file"
        exit 1
    fi

    if [ $enviType == "dev" ]; then
        paramsFileBuild='deployStorageAccount.Dev.Params.bicepparam'
    else
        paramsFileBuild='deployStorageAccount.Prod.Params.bicepparam'
    fi

    paramFileOutput='storageAccount.parameters.json'

    az bicep build-params -f ../$paramsFileBuild --outfile $paramFileOutput

    echo "Deploying storage account in resource group: $resourceGroup"
    az deployment group create \
        --name "storageAccount-$enviType" \
        --resource-group "$resourceGroup" \
        --template-file ../deployStorage.bicep \
        --parameters @$paramFileOutput

    if [ $? -ne 0 ]; then
        echo "Failed to deploy storage account"
        exit 1
    fi
}

validateInputs() {
    if [ "$enviType" != "Dev" ] && [ "$enviType" != "Prod" ]; then
        echo "Invalid environment type. Valid values are dev or prod"
        exit 1
    fi
}

clear
validateInputs
# Main script execution
createResourceGroup
deployStorageAccount