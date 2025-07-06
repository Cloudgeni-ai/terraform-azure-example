terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configure the Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

# Data source for current client configuration
data "azurerm_client_config" "current" {}

# Local values for naming and tagging
locals {
  environment = var.environment
  location    = var.location
  project     = var.project_name
  
  # Generate unique names with environment and location
  resource_group_name  = "${local.project}-${local.environment}-rg"
  vnet_name           = "${local.project}-${local.environment}-vnet"
  nsg_name            = "${local.project}-${local.environment}-nsg"
  key_vault_name      = "${local.project}-${local.environment}-kv-${random_string.suffix.result}"
  storage_account_name = "${local.project}${local.environment}st${random_string.suffix.result}"
  
  # Common tags
  common_tags = merge(var.tags, {
    Environment = local.environment
    Project     = local.project
    Location    = local.location
    ManagedBy   = "terraform"
  })
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# Call the composite module
module "azure_foundation" {
  source = "../../modules/azure-foundation"

  environment = local.environment
  location    = local.location
  tags        = local.common_tags

  # Resource Group
  resource_group_name = local.resource_group_name

  # Virtual Network
  vnet_name          = local.vnet_name
  vnet_address_space = var.vnet_address_space
  subnets           = var.subnets

  # Network Security Group
  nsg_name                   = local.nsg_name
  nsg_custom_security_rules  = var.nsg_custom_security_rules

  # Key Vault
  key_vault_name                              = local.key_vault_name
  key_vault_sku                              = var.key_vault_sku
  key_vault_enabled_for_deployment           = var.key_vault_enabled_for_deployment
  key_vault_enabled_for_disk_encryption      = var.key_vault_enabled_for_disk_encryption
  key_vault_enabled_for_template_deployment  = var.key_vault_enabled_for_template_deployment
  key_vault_purge_protection_enabled         = var.key_vault_purge_protection_enabled
  key_vault_soft_delete_retention_days       = var.key_vault_soft_delete_retention_days

  # Storage Account
  storage_account_name                         = local.storage_account_name
  storage_account_tier                         = var.storage_account_tier
  storage_account_replication_type             = var.storage_account_replication_type
  storage_account_kind                         = var.storage_account_kind
  storage_enable_https_traffic_only            = var.storage_enable_https_traffic_only
  storage_min_tls_version                      = var.storage_min_tls_version
  storage_blob_soft_delete_retention_days      = var.storage_blob_soft_delete_retention_days
  storage_container_soft_delete_retention_days = var.storage_container_soft_delete_retention_days
} 