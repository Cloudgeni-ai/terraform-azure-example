terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Resource Group
module "resource_group" {
  source = "github.com/Cloudgeni-ai/terraform-azure-modules//modules/azure-resource-group"

  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

# Virtual Network
module "virtual_network" {
  source = "github.com/Cloudgeni-ai/terraform-azure-modules//modules/azure-virtual-network"

  name                = var.vnet_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  address_space = var.vnet_address_space

  subnets = var.subnets

  tags = var.tags

  depends_on = [module.resource_group]
}

# Network Security Group
module "network_security_group" {
  source = "github.com/Cloudgeni-ai/terraform-azure-modules//modules/azure-network-security-group"

  name                = var.nsg_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  custom_security_rules = var.nsg_custom_security_rules

  tags = var.tags

  depends_on = [module.resource_group]
}

# Key Vault
module "key_vault" {
  source = "github.com/Cloudgeni-ai/terraform-azure-modules//modules/azure-key-vault"

  name                = var.key_vault_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku_name = var.key_vault_sku
  
  enabled_for_deployment          = var.key_vault_enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault_enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault_enabled_for_template_deployment
  
  purge_protection_enabled = var.key_vault_purge_protection_enabled
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days

  # Fix validation issue by providing empty object instead of null
  network_acls = {
    default_action = "Allow"
  }

  tags = var.tags

  depends_on = [module.resource_group]
}

# Storage Account
module "storage_account" {
  source = "github.com/Cloudgeni-ai/terraform-azure-modules//modules/azure-storage-account"

  name                = var.storage_account_name
  name_override       = var.storage_account_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind

  enable_https_traffic_only = var.storage_enable_https_traffic_only
  min_tls_version          = var.storage_min_tls_version

  blob_properties = {
    versioning_enabled = true
    delete_retention_policy = {
      days = var.storage_blob_soft_delete_retention_days
    }
    container_delete_retention_policy = {
      days = var.storage_container_soft_delete_retention_days
    }
  }

  # Fix validation issues by providing empty objects instead of null
  network_rules = {
    default_action = "Allow"
  }

  identity = {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [module.resource_group]
} 