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

### Setup

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd terraform-azure-example
   ```

2. **Login to Azure:**
   ```bash
   az login
   ```

3. **Deploy to staging:**
   ```bash
   ./scripts/deploy.sh staging
   ```

4. **Deploy to production:**
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