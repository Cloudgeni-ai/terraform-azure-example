#!/bin/bash

# Terraform Azure Example - Deployment Script
# Usage: ./deploy.sh <environment>
# Example: ./deploy.sh staging

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

print_message $BLUE "🚀 Starting deployment for environment: $ENVIRONMENT"

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

# Confirmation for production
if [ "$ENVIRONMENT" == "prod" ]; then
    print_message $YELLOW "⚠️  WARNING: You are about to deploy to PRODUCTION environment!"
    print_message $YELLOW "Subscription: $SUBSCRIPTION"
    read -p "Are you sure you want to continue? (yes/no): " -r
    if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        print_message $RED "Deployment cancelled."
        exit 1
    fi
fi

# Initialize Terraform
print_message $BLUE "🔧 Initializing Terraform..."
terraform init

# Validate Terraform configuration
print_message $BLUE "✅ Validating Terraform configuration..."
terraform validate

# Format Terraform files
print_message $BLUE "🎨 Formatting Terraform files..."
terraform fmt -recursive

# Plan deployment
print_message $BLUE "📋 Planning deployment..."
terraform plan -out=tfplan

# Apply deployment
print_message $BLUE "🚀 Applying deployment..."
terraform apply tfplan

# Clean up plan file
rm -f tfplan

print_message $GREEN "✅ Deployment completed successfully!"
print_message $GREEN "Environment: $ENVIRONMENT"
print_message $GREEN "Subscription: $SUBSCRIPTION"

# Show outputs
print_message $BLUE "📊 Deployment outputs:"
terraform output

print_message $GREEN "🎉 Deployment finished! Your infrastructure is ready." 