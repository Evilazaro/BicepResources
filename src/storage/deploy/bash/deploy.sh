#!/bin/bash

set -euo pipefail

# Variables
resourceGroup='storageRg'
location='eastus'
enviType="${1:-dev}"

# Function to create resource group
createResourceGroup() {
    echo "Creating resource group: $resourceGroup in location: $location"
    az group create --name "$resourceGroup" --location "$location"
}

# Function to deploy storage account
deployStorageAccount() {

    echo "Building bicep file"
    az bicep build -f ../../storageAccount.bicep --outfile storageAccount.json

    if [ $? -ne 0 ]; then
        echo "Failed to build bicep file"
        exit 1
    fi

    if [ $enviType == "dev" ]; then
        paramsFileBuild='storageAccount.Dev.Params.bicepparam'
    else
        paramsFileBuild='storageAccount.Prod.Params.bicepparam'
    fi

    paramFileOutput='storageAccount.parameters.json'

    az bicep build-params -f ../../$paramsFileBuild --outfile $paramFileOutput

    echo "Deploying storage account in resource group: $resourceGroup"
    az deployment group create \
        --name "storageAccount-$enviType" \
        --resource-group "$resourceGroup" \
        --template-file ../../storageAccount.bicep \
        --parameters @$paramFileOutput

    if [ $? -ne 0 ]; then
        echo "Failed to deploy storage account"
        exit 1
    fi
}

validateInputs() {
    if [ "$enviType" != "dev" ] && [ "$enviType" != "prod" ]; then
        echo "Invalid environment type. Valid values are dev or prod"
        exit 1
    fi
}

clear
validateInputs
# Main script execution
createResourceGroup
deployStorageAccount