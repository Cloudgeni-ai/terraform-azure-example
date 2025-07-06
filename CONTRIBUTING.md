# Contributing to Terraform Azure Example

Thank you for your interest in contributing to this Terraform Azure example project! This guide will help you get started.

## 🚀 Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure subscription for testing
- Git

### Setting Up Development Environment

1. **Fork the repository** on GitHub
2. **Clone your fork:**
   ```bash
   git clone https://github.com/your-username/terraform-azure-example
   cd terraform-azure-example
   ```

3. **Set up Azure authentication:**
   ```bash
   az login
   az account set --subscription "Your Test Subscription"
   ```

4. **Copy example configurations:**
   ```bash
   cd environments/staging
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your test values
   ```

5. **Test your setup:**
   ```bash
   terraform init
   terraform validate
   terraform plan
   ```

## 📝 How to Contribute

### Reporting Issues

- Use the GitHub issue tracker
- Include Terraform version, Azure CLI version, and environment details
- Provide clear steps to reproduce the issue
- Include relevant error messages and logs

### Submitting Changes

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow existing code style and patterns
   - Update documentation if needed
   - Test your changes thoroughly

3. **Validate your changes:**
   ```bash
   # Check formatting
   terraform fmt -recursive

   # Validate syntax
   terraform validate

   # Test deployment (in staging)
   ./scripts/deploy.sh staging
   
   # Clean up
   ./scripts/destroy.sh staging
   ```

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: add new feature description"
   ```

5. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request** on GitHub

## 🔧 Development Guidelines

### Code Style

- Use consistent indentation (2 spaces)
- Follow Terraform naming conventions
- Include comments for complex logic
- Use descriptive variable names

### Configuration Guidelines

- **Environment Separation**: Keep staging and production configurations separate
- **DRY Principle**: Use the shared module approach
- **Security**: Never commit sensitive data (use .tfvars.example)
- **Tagging**: Include proper resource tags for cost tracking

### Testing

- Always test in staging environment first
- Validate with `terraform validate`
- Check with `terraform plan`
- Test deployment and destruction scripts

### Documentation

- Update README.md for new features
- Add comments to complex configurations
- Update variable descriptions
- Include examples in terraform.tfvars.example files

## 📁 Project Structure

```
terraform-azure-example/
├── environments/           # Environment-specific configurations
│   ├── staging/           # Staging environment
│   └── prod/              # Production environment
├── modules/               # Local modules
│   └── azure-foundation/  # Composite module
├── scripts/               # Deployment automation
└── docs/                  # Additional documentation
```

## 🔒 Security Considerations

- Never commit real subscription IDs, secrets, or keys
- Use Azure Key Vault for sensitive data
- Follow principle of least privilege
- Regular security reviews of configurations

## 🐛 Common Issues

### Authentication Problems
- Ensure `az login` is successful
- Check subscription permissions
- Verify Azure CLI version compatibility

### Resource Conflicts
- Use unique resource names
- Check for existing resources in your subscription
- Use different resource groups for testing

### Module Version Issues
- Always specify module versions
- Test with latest module versions
- Check for breaking changes in remote modules

## 📞 Getting Help

- Check existing issues and documentation
- Ask questions in GitHub discussions
- Reach out to maintainers for guidance

## 🎯 Types of Contributions Needed

- **Bug fixes**: Fix issues with existing configurations
- **New examples**: Add new use cases or scenarios
- **Documentation**: Improve guides and examples
- **Testing**: Add validation and testing improvements
- **Security**: Security enhancements and best practices

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the Apache 2.0 License.

Thank you for contributing! 🙏 