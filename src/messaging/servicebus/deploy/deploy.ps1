Set-ExecutionPolicy Bypass -Scope Process -Force; 

# Enable strict mode for error handling
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Variables
$resourceGroup = 'servicebus-rg'
$location = 'eastus'

# Function to create resource group
function Create-ResourceGroup {
    Write-Output "Creating resource group: $resourceGroup in location: $location"
    try {
        az group create --name $resourceGroup --location $location
        Write-Output "Resource group created successfully."
    } catch {
        Write-Error "Failed to create resource group: $_"
        exit 1
    }
}

# Function to deploy service bus
function Deploy-ServiceBus {
    Write-Output "Building bicep file"
    try {
        az bicep build -f ../deployServiceBus.bicep
        Write-Output "Bicep file built successfully."
    } catch {
        Write-Error "Failed to build bicep file: $_"
        exit 1
    }

    $tags = @{ environment = 'dev'; department = 'IT' }

    try {

        for ($i = 0; $i -lt 2; $i++) {
            Write-Output "Deploying service bus in resource group: $resourceGroup"
            az deployment group create --resource-group "$resourceGroup" --template-file ../deployServiceBus.bicep --parameters namespaceName="eyraptor-$i"
            Write-Output "Service bus deployed successfully."
        }
        
    } catch {
        Write-Error "Failed to deploy service bus: $_"
        exit 1
    }
}

# Clear the console
Clear-Host

# Execute functions
Create-ResourceGroup
Deploy-ServiceBus