# Resource Group Outputs
output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.azure_foundation.resource_group_name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.azure_foundation.resource_group_id
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = module.azure_foundation.resource_group_location
}

# Virtual Network Outputs
output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = module.azure_foundation.virtual_network_name
}

output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = module.azure_foundation.virtual_network_id
}

output "virtual_network_address_space" {
  description = "Address space of the virtual network"
  value       = module.azure_foundation.virtual_network_address_space
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = module.azure_foundation.subnet_ids
}

# Network Security Group Outputs
output "network_security_group_name" {
  description = "Name of the network security group"
  value       = module.azure_foundation.network_security_group_name
}

output "network_security_group_id" {
  description = "ID of the network security group"
  value       = module.azure_foundation.network_security_group_id
}

# Key Vault Outputs
output "key_vault_name" {
  description = "Name of the key vault"
  value       = module.azure_foundation.key_vault_name
}

output "key_vault_id" {
  description = "ID of the key vault"
  value       = module.azure_foundation.key_vault_id
}

output "key_vault_uri" {
  description = "URI of the key vault"
  value       = module.azure_foundation.key_vault_uri
}

# Storage Account Outputs
output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.azure_foundation.storage_account_name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.azure_foundation.storage_account_id
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = module.azure_foundation.storage_account_primary_blob_endpoint
}

# Environment Information
output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
} 