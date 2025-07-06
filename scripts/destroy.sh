#!/bin/bash

# Terraform Azure Example - Destroy Script
# Usage: ./destroy.sh <environment>
# Example: ./destroy.sh staging

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to print usage
print_usage() {
    echo "Usage: $0 <environment>"
    echo "Environments: staging, prod"
    echo ""
    echo "Example: $0 staging"
    echo "Example: $0 prod"
}

# Check if environment is provided
if [ $# -eq 0 ]; then
    print_message $RED "Error: No environment specified."
    print_usage
    exit 1
fi

ENVIRONMENT=$1

# Validate environment
if [ "$ENVIRONMENT" != "staging" ] && [ "$ENVIRONMENT" != "prod" ]; then
    print_message $RED "Error: Invalid environment '$ENVIRONMENT'."
    print_message $YELLOW "Valid environments: staging, prod"
    exit 1
fi

# Set environment directory
ENV_DIR="environments/${ENVIRONMENT}"

# Check if environment directory exists
if [ ! -d "$ENV_DIR" ]; then
    print_message $RED "Error: Environment directory '$ENV_DIR' not found."
    exit 1
fi

print_message $BLUE "🔥 Starting destruction for environment: $ENVIRONMENT"

# Navigate to environment directory
cd "$ENV_DIR"

# Check if Azure CLI is installed and logged in
if ! command -v az &> /dev/null; then
    print_message $RED "Error: Azure CLI is not installed."
    print_message $YELLOW "Please install Azure CLI: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if user is logged in to Azure
if ! az account show &> /dev/null; then
    print_message $RED "Error: Not logged in to Azure."
    print_message $YELLOW "Please run: az login"
    exit 1
fi

# Get current Azure subscription
SUBSCRIPTION=$(az account show --query name --output tsv)
print_message $BLUE "📋 Current Azure Subscription: $SUBSCRIPTION"

# Enhanced confirmation for production
if [ "$ENVIRONMENT" == "prod" ]; then
    print_message $RED "🚨 DANGER: You are about to DESTROY the PRODUCTION environment!"
    print_message $RED "This action will permanently delete all resources!"
    print_message $YELLOW "Subscription: $SUBSCRIPTION"
    
    # Double confirmation for production
    read -p "Type 'DELETE-PRODUCTION' to confirm: " -r
    if [[ ! $REPLY == "DELETE-PRODUCTION" ]]; then
        print_message $RED "Destruction cancelled."
        exit 1
    fi
    
    print_message $YELLOW "Final confirmation. Are you absolutely sure? (yes/no): "
    read -p "" -r
    if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        print_message $RED "Destruction cancelled."
        exit 1
    fi
else
    # Standard confirmation for staging
    print_message $YELLOW "⚠️  WARNING: You are about to destroy the $ENVIRONMENT environment!"
    print_message $YELLOW "Subscription: $SUBSCRIPTION"
    read -p "Are you sure you want to continue? (yes/no): " -r
    if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        print_message $RED "Destruction cancelled."
        exit 1
    fi
fi

# Check if terraform state exists
if [ ! -f "terraform.tfstate" ] && [ ! -f ".terraform/terraform.tfstate" ]; then
    print_message $YELLOW "No Terraform state found. Nothing to destroy."
    exit 0
fi

# Initialize Terraform (in case it's not initialized)
print_message $BLUE "🔧 Initializing Terraform..."
terraform init

# Validate Terraform configuration
print_message $BLUE "✅ Validating Terraform configuration..."
terraform validate

# Plan destruction
print_message $BLUE "📋 Planning destruction..."
terraform plan -destroy -out=destroy-plan

# Show what will be destroyed
print_message $YELLOW "The following resources will be destroyed:"
terraform show destroy-plan

# Final confirmation before destroying
print_message $YELLOW "This is your last chance to cancel!"
read -p "Proceed with destruction? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    print_message $RED "Destruction cancelled."
    rm -f destroy-plan
    exit 1
fi

# Apply destruction
print_message $BLUE "🔥 Destroying infrastructure..."
terraform apply destroy-plan

# Clean up plan file
rm -f destroy-plan

print_message $GREEN "✅ Destruction completed successfully!"
print_message $GREEN "Environment: $ENVIRONMENT"
print_message $GREEN "Subscription: $SUBSCRIPTION"

# Verify no resources remain
print_message $BLUE "🔍 Verifying resource cleanup..."
if terraform show | grep -q "No state"; then
    print_message $GREEN "✅ All resources have been successfully destroyed."
else
    print_message $YELLOW "⚠️  Some resources may still exist. Check the output above."
fi

print_message $GREEN "🎉 Destruction finished! All resources have been cleaned up."