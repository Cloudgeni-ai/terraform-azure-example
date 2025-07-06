# Terraform Azure Example

This repository demonstrates how to use the [Cloudgeni-ai/terraform-azure-modules](https://github.com/Cloudgeni-ai/terraform-azure-modules) collection to deploy Azure infrastructure across multiple environments using Terraform best practices.

## 🏗️ Architecture Overview

This example deploys a foundational Azure infrastructure including:

- **Resource Group** - Container for all resources
- **Virtual Network** - Network infrastructure with subnets
- **Network Security Group** - Network security rules
- **Key Vault** - Secure secrets management
- **Storage Account** - Blob storage with encryption

## 📁 Repository Structure

```
terraform-azure-example/
├── environments/
│   ├── staging/           # Staging environment configuration
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars
│   └── prod/              # Production environment configuration
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
├── modules/
│   └── azure-foundation/  # Local composite module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── scripts/               # Deployment scripts
│   ├── deploy.sh
│   └── destroy.sh
├── .gitignore
├── LICENSE
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription with appropriate permissions

### Azure Subscription Configuration

This project is designed to work with **your** Azure subscription. You have several options to configure authentication:

#### Option 1: Azure CLI Login (Recommended)
```bash
# Login to Azure - this will automatically set your subscription
az login

# If you have multiple subscriptions, list them and set the desired one
az account list --output table
az account set --subscription "Your Subscription Name or ID"
```

#### Option 2: Environment Variables
```bash
export ARM_SUBSCRIPTION_ID="your-subscription-id"
export ARM_TENANT_ID="your-tenant-id"
export ARM_CLIENT_ID="your-client-id"  # If using Service Principal
export ARM_CLIENT_SECRET="your-client-secret"  # If using Service Principal
```

#### Option 3: Set in terraform.tfvars
Uncomment and set the subscription_id in your `terraform.tfvars` file:
```hcl
subscription_id = "your-subscription-id-here"
```

**Note:** The `terraform.tfvars.example` files include examples of all configurable options. Copy these files to `terraform.tfvars` and customize them for your needs.

### Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/terraform-azure-example
   cd terraform-azure-example
   ```

2. **Setup Azure authentication:**
   ```bash
   # Login to Azure
   az login
   
   # (Optional) If you have multiple subscriptions, set the one you want to use:
   az account list --output table
   az account set --subscription "Your Subscription Name"
   ```

3. **Configure your environment:**
   ```bash
   # Copy example configuration for staging
   cd environments/staging
   cp terraform.tfvars.example terraform.tfvars
   
   # Edit the file with your preferences
   nano terraform.tfvars  # or use your preferred editor
   
   # Do the same for production if needed
   cd ../prod
   cp terraform.tfvars.example terraform.tfvars
   nano terraform.tfvars
   
   # Return to root directory
   cd ../..
   ```

4. **Deploy to staging:**
   ```bash
   ./scripts/deploy.sh staging
   ```

5. **Deploy to production:**
   ```bash
   ./scripts/deploy.sh prod
   ```

## 🔧 Configuration

### Environment-Specific Variables

Each environment has its own `terraform.tfvars` file with environment-specific values:

- **Staging**: Smaller, cost-optimized resources
- **Production**: High-availability, production-ready configuration

### Common Variables

All environments share the same variable definitions but use different values based on the environment.

## 🛡️ Security Features

- **Encryption**: All storage encrypted at rest and in transit
- **Network Security**: NSG rules for secure access
- **Key Vault**: Centralized secrets management
- **Private Endpoints**: Secure service connections
- **Managed Identity**: Azure AD integration

## 📊 Outputs

Each environment outputs important resource information:

- Resource Group details
- Virtual Network configuration
- Key Vault URI
- Storage Account endpoints

## 🧹 Cleanup

To destroy infrastructure:

```bash
./scripts/destroy.sh staging
./scripts/destroy.sh prod
```

## 🤝 Contributing

This example follows the same contribution guidelines as the main modules repository.

## 📄 License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Projects

- [Terraform Azure Modules](https://github.com/Cloudgeni-ai/terraform-azure-modules) - The source modules used in this example